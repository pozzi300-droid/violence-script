#!/usr/bin/env python3
import re, sys, os

def extract_vwzwzo_table(src):
    match = re.search(r'vWOWZo\s*=\s*\{(.*?)\}', src, re.DOTALL)
    if not match: return []
    return re.findall(r'"((?:[^"\\]|\\.)*)"', match.group(1))

def decode_lua_string(s):
    result = bytearray()
    i = 0
    while i < len(s):
        if s[i] == '\\' and i + 1 < len(s):
            j = i + 1
            while j < len(s) and j < i + 4 and s[j].isdigit(): j += 1
            if j > i + 1:
                val = int(s[i+1:j])
                if 0 <= val <= 255: result.append(val); i = j; continue
            nxt = s[i+1]
            if nxt == 'n': result.append(10)
            elif nxt == 'r': result.append(13)
            elif nxt == 't': result.append(9)
            elif nxt == '\\': result.append(92)
            elif nxt == '"': result.append(34)
            else: result.append(ord(nxt))
            i += 2
        else: result.append(ord(s[i])); i += 1
    return bytes(result)

def decode_strings(encoded, key_base=31, key_mult=54):
    decoded = {}
    for idx, raw in enumerate(encoded):
        string_idx = idx + 1
        raw_bytes = decode_lua_string(raw)
        xor_key = (key_base + string_idx * key_mult) % 256
        dec = bytes(b ^ xor_key for b in raw_bytes)
        try: decoded[string_idx] = dec.decode('utf-8')
        except: decoded[string_idx] = dec.decode('latin-1')
    return decoded

def main():
    if len(sys.argv) < 3: sys.exit(1)
    with open(sys.argv[1], 'r', errors='ignore') as f: src = f.read()
    encoded = extract_vwzwzo_table(src)
    decoded = decode_strings(encoded)
    def replacer(m):
        idx = int(m.group(1))
        if idx in decoded:
            val = decoded[idx].replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n')
            return f'"{val}"'
        return m.group(0)
    src = re.sub(r'lHnUu\s*\[\s*(\d+)\s*\]', replacer, src)
    start = src.find('local  lHnUu do')
    end = src.find('local w_ZpoH0p1')
    if start >= 0 and end >= 0: src = src[:start] + src[end:]
    with open(sys.argv[2], 'w') as f: f.write(src)
    print(f'Done: {len(src)} bytes')

if __name__ == '__main__': main()
