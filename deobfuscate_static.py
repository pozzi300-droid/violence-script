#!/usr/bin/env python3
"""
Static deobfuscator for BolongBot-obfuscated Lua scripts.
Extracts the string table, decodes via XOR, and replaces all indexed references.
"""
import re
import sys
import os


def extract_vwzwzo_table(src):
    """Extract the vWOWZo encoded string table from source."""
    match = re.search(r'vWOWZo\s*=\s*\{(.*?)\}', src, re.DOTALL)
    if not match:
        print("ERROR: vWOWZo table not found")
        sys.exit(1)
    content = match.group(1)
    # Extract all quoted strings with escape sequences
    strings = re.findall(r'"((?:[^"\\]|\\.)*)"', content)
    return strings


def decode_octal_string(s):
    """Convert octal escape sequences to bytes."""
    result = bytearray()
    i = 0
    while i < len(s):
        if s[i] == '\\' and i + 1 < len(s):
            # Check for octal
            j = i + 1
            while j < len(s) and j < i + 4 and s[j].isdigit():
                j += 1
            if j > i + 1:
                octal = s[i + 1:j]
                try:
                    result.append(int(octal, 8))
                    i = j
                    continue
                except ValueError:
                    pass
            # Other escapes
            nxt = s[i + 1]
            if nxt == 'n':
                result.append(10)
            elif nxt == 'r':
                result.append(13)
            elif nxt == 't':
                result.append(9)
            elif nxt == '\\':
                result.append(92)
            elif nxt == '"':
                result.append(34)
            elif nxt == "'":
                result.append(39)
            else:
                result.append(ord(nxt))
            i += 2
        else:
            result.append(ord(s[i]))
            i += 1
    return bytes(result)


def decode_strings(encoded_strings, key_base=31, key_mult=54):
    """Decode all strings using the XOR algorithm."""
    decoded = {}
    for idx, raw_str in enumerate(encoded_strings):
        string_idx = idx + 1  # 1-based index
        raw_bytes = decode_octal_string(raw_str)
        xor_key = (key_base + string_idx * key_mult) % 256
        decoded_bytes = bytes(b ^ xor_key for b in raw_bytes)
        try:
            decoded[string_idx] = decoded_bytes.decode('utf-8')
        except UnicodeDecodeError:
            decoded[string_idx] = decoded_bytes.decode('latin-1')
    return decoded


def replace_string_refs(src, decoded):
    """Replace lHnUu[N] references with decoded strings."""
    def replacer(match):
        idx = int(match.group(1))
        if idx in decoded:
            val = decoded[idx]
            # Escape for Lua string literal
            escaped = val.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t').replace('\0', '\\0')
            return f'"{escaped}"'
        return match.group(0)

    # Replace lHnUu[N] patterns
    result = re.sub(r'lHnUu\s*\[\s*(\d+)\s*\]', replacer, src)
    return result


def rename_mangled_vars(src):
    """Rename obfuscated variable names to readable ones."""
    # Map of known obfuscated names to readable names based on context
    renames = {
        'b0W0wpHoxmHDWX': 'LIB',  # Main library/module table
        'w_ZpoH0p1': 'ENV',  # Environment table
        'OD_0p_00Xblo': 'GetService',
        'u0xpmq_WoUlm': 'Players',
        'BQbuWD1UMvux': 'RunService',
        'Wv0HMNDowvn': 'Config',
        'pUXUIwpIMmH': 'Notify',
        'currentAvatarInput': 'currentAvatarInput',
    }
    for old, new in renames.items():
        src = re.sub(r'\b' + re.escape(old) + r'\b', new, src)
    return src


def format_code(src):
    """Basic formatting: add newlines after semicolons and end keywords."""
    # Add newline after ';' (not inside strings)
    result = []
    in_string = None
    i = 0
    while i < len(src):
        ch = src[i]
        if in_string:
            result.append(ch)
            if ch == '\\':
                i += 1
                if i < len(src):
                    result.append(src[i])
            elif ch == in_string:
                in_string = None
        else:
            if ch == '"' or ch == "'":
                in_string = ch
                result.append(ch)
            elif ch == ';':
                result.append(';\n')
            elif ch == '{':
                result.append('{\n')
            elif ch == '}':
                result.append('\n}')
            else:
                result.append(ch)
        i += 1
    return ''.join(result)


def main():
    if len(sys.argv) < 3:
        print("Usage: deobfuscate_static.py <input.lua> <output.lua>")
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    with open(input_path, 'r', errors='ignore') as f:
        src = f.read()

    print(f"[*] Loaded {len(src)} bytes from {input_path}")

    # Step 1: Extract encoded strings
    encoded = extract_vwzwzo_table(src)
    print(f"[*] Found {len(encoded)} encoded strings in vWOWZo table")

    # Step 2: Decode strings
    decoded = decode_strings(encoded)
    print(f"[*] Decoded {len(decoded)} strings")

    # Show some samples
    for i in [1, 2, 3, 100, 500, 1000]:
        if i in decoded:
            print(f"  [{i}]: {decoded[i][:60]}")

    # Step 3: Replace string references
    print("[*] Replacing lHnUu[N] references...")
    deobf = replace_string_refs(src, decoded)

    # Step 4: Remove the decoder block (vWOWZo table and decode loop)
    # Find and remove from "local lHnUu do" to "end local w_ZpoH0p1"
    decoder_start = deobf.find('local  lHnUu do')
    decoder_end = deobf.find('local w_ZpoH0p1')
    if decoder_start >= 0 and decoder_end >= 0:
        # Keep a comment explaining what was removed
        deobf = deobf[:decoder_start] + '-- [String table decoded and inlined]\n' + deobf[decoder_end:]
        print(f"[*] Removed decoder block ({decoder_end - decoder_start} chars)")

    # Step 5: Rename mangled variables
    print("[*] Renaming mangled variables...")
    deobf = rename_mangled_vars(deobf)

    # Step 6: Basic formatting
    print("[*] Formatting code...")
    deobf = format_code(deobf)

    # Write output
    os.makedirs(os.path.dirname(output_path) if os.path.dirname(output_path) else '.', exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(deobf)

    print(f"[+] Written {len(deobf)} bytes to {output_path}")
    print(f"[+] Deobfuscation complete!")


if __name__ == '__main__':
    main()
