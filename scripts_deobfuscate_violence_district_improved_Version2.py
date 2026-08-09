#!/usr/bin/env python3
"""
Improved safe deobfuscator for ViolenceDistrict.lua
- Does NOT execute any Lua code
- Extracts escaped string literals and numeric tables (arrays) from Lua source
- Builds candidate byte blobs and tries many transforms:
    * raw, reversed
    * single-byte XOR, repeating-key XOR (keylen 1..32)
    * known-plaintext guided repeating-key recovery using 'local ' / 'function '
    * add/sub constant
    * bit rotations (rol/ror), shifts
    * substitution-table inversion if a 256-element table is found
- Scores candidates by presence of Lua keywords, printable fraction and entropy
- Saves top candidates into output directory
"""
import re, sys, os, math, itertools, collections
from hashlib import sha1

# Config
KEYWORDS = [b'local ', b'function ', b'return ', b'--', b'require ', b'loadstring', b'load(']
MAX_KEYLEN = 32
TOP_SAVE = 25

def read_file(path):
    with open(path, 'r', errors='ignore') as f:
        return f.read()

# --- Extraction utilities ---

# Extract single/double quoted strings that include backslash escapes (octal/hex)
STR_LIT_RE = re.compile(r'(["\'])(.*?\\[0-9A-Fa-fxX]{1,3}.*?)(?<!\\)\1', re.S)

# Extract numeric tables like {1,2,3,...} possibly spanning multiple lines
NUM_TABLE_RE = re.compile(r'\{([0-9,\s]+)\}')

def extract_escaped_strings(text):
    return [m.group(2) for m in STR_LIT_RE.finditer(text)]

def extract_numeric_tables(text):
    tables = []
    for m in NUM_TABLE_RE.finditer(text):
        body = m.group(1)
        nums = []
        for token in re.split(r'[, \n\r\t]+', body):
            if token.strip() == '':
                continue
            try:
                n = int(token.strip())
            except:
                n = None
            if n is not None and 0 <= n <= 65535:
                nums.append(n)
        if nums:
            tables.append(nums)
    return tables

# Unescape octal/hex and common escapes to raw bytes
OCT_RE = re.compile(r'\\([0-7]{1,3})')
HEX_RE = re.compile(r'\\x([0-9A-Fa-f]{2})')

def unescape_string_literal(s):
    # First replace common escapes (we keep backslashes as markers)
    s = s.replace(r'\n', '\n').replace(r'\r', '\r').replace(r'\t', '\t').replace(r'\\', '\\') \
         .replace(r"\'", "'").replace(r'\"', '"')
    out = bytearray()
    i = 0
    L = len(s)
    while i < L:
        ch = s[i]
        if ch == '\\' and i+1 < L:
            rem = s[i:]
            m_oct = OCT_RE.match(rem)
            if m_oct:
                out.append(int(m_oct.group(1), 8))
                i += 1 + len(m_oct.group(1)); continue
            m_hex = HEX_RE.match(rem)
            if m_hex:
                out.append(int(m_hex.group(1), 16))
                i += 2 + len(m_hex.group(1)); continue
            nxt = s[i+1]
            if nxt == 'n': out.append(10)
            elif nxt == 'r': out.append(13)
            elif nxt == 't': out.append(9)
            elif nxt == '\\': out.append(92)
            elif nxt == '"': out.append(34)
            elif nxt == "'": out.append(39)
            else:
                out.append(ord(nxt))
            i += 2
        else:
            out.append(ord(ch))
            i += 1
    return bytes(out)

# Flatten numeric table to bytes if within 0..255
def table_to_bytes(tbl):
    if all(0 <= x <= 255 for x in tbl):
        return bytes(tbl)
    return None

# --- Transformations ---

def rolling_xor(data, key):
    return bytes([data[i] ^ key[i % len(key)] for i in range(len(data))])

def single_xor(data, k):
    return bytes([b ^ k for b in data])

def add_const(data, k):
    return bytes([(b + k) & 0xFF for b in data])

def sub_const(data, k):
    return bytes([(b - k) & 0xFF for b in data])

def rol8(b, n): return ((b << n) & 0xFF) | ((b & 0xFF) >> (8 - n))
def ror8(b, n): return ((b & 0xFF) >> n) | ((b << (8 - n)) & 0xFF)

def rol_bytes(data, n):
    return bytes([rol8(b, n) for b in data])

def ror_bytes(data, n):
    return bytes([ror8(b, n) for b in data])

def invert_substitution_table(tbl):
    # tbl: bytes of length 256 where tbl[i] is mapped value of i
    if len(tbl) != 256: return None
    inv = [None]*256
    for i,v in enumerate(tbl):
        inv[v] = i
    if any(x is None for x in inv):
        return None
    return bytes(inv)

# --- Scoring heuristics ---

def printable_fraction(b):
    if not b: return 0.0
    pr = sum(32 <= c < 127 for c in b)
    return pr / len(b)

def shannon_entropy(b):
    if not b: return 0.0
    freq = collections.Counter(b)
    e = 0.0
    L = len(b)
    for v in freq.values():
        p = v / L
        e -= p * math.log2(p)
    return e

def keyword_score(b):
    score = 0
    for kw in KEYWORDS:
        count = b.count(kw)
        if count:
            score += 5 * count
    # small bonus for "local " at start
    if b.startswith(b'local ') or b.startswith(b'--'):
        score += 10
    return score

def total_score(b):
    kw = keyword_score(b)
    pr = printable_fraction(b)
    ent = shannon_entropy(b)
    # heuristic: more keywords and printable space is good, lower entropy good
    return kw * 1.0 + pr * 30.0 - ent * 2.0

# known-plaintext attempt: try to deduce repeating key of length L that maps some positions to target text
def known_plaintext_recover(data, target=b'local '):
    candidates = []
    N = len(data)
    for L in range(1, min(MAX_KEYLEN, 64)+1):
        # attempt sliding alignment
        for start in range(0, min(200, N)):
            if start + len(target) > N: break
            key = bytearray(L)
            ok = True
            for i, tch in enumerate(target):
                key[(start + i) % L] = data[start + i] ^ tch
            # check consistency across positions where same mod L repeated inside the sample
            # build key by scanning many occurrences of target-like pattern: try to validate
            # Validate: apply key and test if many 'local ' occurrences appear
            out = rolling_xor(data, bytes(key))
            cnt = out.count(target)
            if cnt >= 1:
                candidates.append((bytes(key), out, L, start, cnt))
    # Deduplicate by key
    uniq = {}
    for key, out, L, start, cnt in candidates:
        if key not in uniq:
            uniq[key] = (out, L, start, cnt)
    res = []
    for k,(out,L,start,cnt) in uniq.items():
        res.append((k,out,L,start,cnt))
    return res

# --- Main orchestration ---

def collect_blobs(src_text):
    blobs = []
    # 1) escaped strings
    for s in extract_escaped_strings(src_text):
        b = unescape_string_literal(s)
        if b:
            blobs.append( ('string_literal', b) )
    # 2) numeric tables
    for tbl in extract_numeric_tables(src_text):
        b = table_to_bytes(tbl)
        if b:
            blobs.append( ('numeric_table', b) )
    return blobs

def generate_candidate_blobs(blobs):
    # Basic combine strategies:
    # - each blob individually
    # - concatenation in file order
    # - concatenation + in-order reversal of parts
    candidates = []
    if not blobs: return candidates
    datas = [b for _,b in blobs]
    # each individually
    for i,b in enumerate(datas):
        candidates.append( ('part_%d' % i, b) )
    # concat all
    concat = b''.join(datas)
    candidates.append(('concat_all', concat))
    # concat reversed parts
    concat_revparts = b''.join(datas[::-1])
    candidates.append(('concat_revparts', concat_revparts))
    # also interleave small pieces if many parts (adjacent join)
    if len(datas) > 1:
        inter = bytearray()
        for part in datas:
            inter.extend(part[:max(1, len(part)//10)])
        candidates.append(('inter_leading_chunks', bytes(inter)))
    return candidates

def try_many_transforms(name, blob, outdir, results):
    # raw
    def save_candidate(tag, data):
        sc = total_score(data)
        key = (sc, tag, name, data)
        results.append(key)
    if not blob: return

    save_candidate('raw', blob)
    # reversed
    save_candidate('reversed', blob[::-1])
    # rol/ror 1..7
    for n in range(1,8):
        save_candidate(f'rol{n}', rol_bytes(blob, n))
        save_candidate(f'ror{n}', ror_bytes(blob, n))
    # add/sub constant
    for k in (1,2,4,8,13,17,31,55,85,127):
        save_candidate(f'add_{k}', add_const(blob, k))
        save_candidate(f'sub_{k}', sub_const(blob, k))
    # single-byte xor (try 0..255 but sample common ones first)
    for k in [0,1,2,3,7,8,13,31,42,55,85,127,255]:
        save_candidate(f'xor_{k}', single_xor(blob, k))
    # try all single-byte xor but limit cost
    for k in range(0,256):
        save_candidate(f'xor_{k}', single_xor(blob, k))
    # repeating-key XOR keys length 1..MAX_KEYLEN using heuristics:
    # try brute force small keys by deriving key from expected "local " at a few offsets
    kp = known_plaintext_recover(blob, b'local ')
    for key, out, L, start, cnt in kp:
        save_candidate(f'kp_xor_len{L}_at{start}_cnt{cnt}', out)
    # brute-forcing repeating key by greedy freq method for each keylen (derive key by most frequent mapping)
    for L in range(1, min(MAX_KEYLEN, max(1, len(blob)) )+1):
        key = bytearray()
        for i in range(L):
            # take bytes at positions i, i+L, ...
            seq = blob[i::L]
            if not seq: key.append(0); continue
            # assume most frequent cipher byte maps to space (0x20) or 'l' (0x6c) -> try both
            freq = collections.Counter(seq)
            most, _ = freq.most_common(1)[0]
            cand_keys = [most ^ 0x20, most ^ 0x6c, most ^ ord('('), most ^ ord('d')]
            # choose smallest xor (heuristic)
            key.append(cand_keys[0] & 0xFF)
        out = rolling_xor(blob, bytes(key))
        save_candidate(f'periodic_guess_{L}', out)
    # try substitution invert if there is 256-length table candidate elsewhere: not done here, performed globally
    return

def attempt_substitution_using_tables(src_blobs, candidates_list):
    # find any 256-length blob and try invert as substitution table
    for name, b in src_blobs:
        if len(b) == 256:
            inv = invert_substitution_table(b)
            if inv:
                # apply inverse mapping to all concatenated blobs
                concat = b''.join([x for _,x in src_blobs])
                mapped = bytes([inv[c] for c in concat])
                # save with heuristic name
                candidates_list.append((sha1(mapped).hexdigest()[:8], mapped))
                # also try reversed mapping (just in case)
                mapped2 = bytes([b[c] for c in concat])
                candidates_list.append((sha1(mapped2).hexdigest()[:8]+'_dir', mapped2))

def save_top_candidates(results, outdir):
    # results: list of tuples (score, tag, name, data)
    results_sorted = sorted(results, key=lambda x: x[0], reverse=True)
    saved = 0
    seen_hashes = set()
    os.makedirs(outdir, exist_ok=True)
    # Save top N
    for sc, tag, name, data in results_sorted[:TOP_SAVE]:
        h = sha1(data).hexdigest()
        if h in seen_hashes:
            continue
        seen_hashes.add(h)
        fname = f'candidate_{saved:02d}_{int(sc):+04d}_{tag}_{name[:40].replace(\" \",\"_\")}.lua'
        fname = re.sub(r'[^A-Za-z0-9._-]', '_', fname)
        path = os.path.join(outdir, fname)
        try:
            text = data.decode('utf-8')
        except:
            text = data.decode('latin1', errors='replace')
        with open(path, 'w', encoding='utf-8') as fo:
            fo.write(text)
        saved += 1
    # also save raw concatenated binary and original
    return saved

def main():
    if len(sys.argv) < 3:
        print("Usage: deobfuscate_violence_district_improved.py <input.lua> <output_dir>")
        sys.exit(1)
    inpath = sys.argv[1]; outdir = sys.argv[2]
    os.makedirs(outdir, exist_ok=True)
    src = read_file(inpath)
    blobs = collect_blobs(src)
    print(f"Found {len(blobs)} candidate raw blobs from literals/tables.")
    for i,(nm,b) in enumerate(blobs):
        print(f" blob[{i}] type={nm} len={len(b)}")
    cand_sources = generate_candidate_blobs(blobs)
    print(f"Generated {len(cand_sources)} initial candidate blob(s).")
    results = []
    # Global substitution table attempt
    attempt_substitution_using_tables(blobs, [])
    # For each candidate blob, try many transforms
    for name,b in cand_sources:
        print(f"Processing candidate source '{name}' len={len(b)}")
        try_many_transforms(name, b, outdir, results)
    # Score and save
    print(f"Total candidates generated: {len(results)}. Scoring and saving top results...")
    saved = save_top_candidates(results, outdir)
    # Save original file and raw blobs
    with open(os.path.join(outdir, 'original.lua'), 'w', encoding='utf-8', errors='ignore') as fo:
        fo.write(src)
    print(f"Saved {saved} candidate files to '{outdir}'. Also saved original.lua.")
    print("Run results: check candidates manually. If needed, I can expand key length, try permutations, or implement a custom decoder once you share more of the file or the patterns found in it.")

if __name__ == '__main__':
    main()