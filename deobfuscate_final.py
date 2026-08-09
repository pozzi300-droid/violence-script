#!/usr/bin/env python3
"""
Final deobfuscator - makes code fully readable
- Proper formatting with newlines
- Rename all obfuscated variables
- Fold all constant expressions
- Clean up string access patterns
"""
import re
import sys
import os


def fold_all_constants(src):
    """Fold all constant arithmetic expressions."""
    # Pattern: (num op num) - handle multiple times for nested
    for _ in range(5):  # Multiple passes for nested expressions
        src = re.sub(
            r'\(\s*(-?\d+)\s*([+\-*/%])\s*(-?\d+)\s*\)',
            lambda m: str(eval(f"{m.group(1)}{m.group(2)}{m.group(3)}")),
            src
        )
    # Also handle patterns like (- num + num)
    src = re.sub(r'\(\s*-\s*(\d+)\s*\+\s*(\d+)\s*\)', 
                 lambda m: str(int(m.group(2)) - int(m.group(1))), src)
    src = re.sub(r'\(\s*(\d+)\s*-\s*(\d+)\s*\)',
                 lambda m: str(int(m.group(1)) - int(m.group(2))), src)
    # Clean up any remaining (-X +Y) patterns
    src = re.sub(r'\(\s*-\s*(\d+)\s*\+\s*(\d+)\s*\)',
                 lambda m: str(int(m.group(2)) - int(m.group(1))), src)
    return src


def format_code(src):
    """Format code with proper newlines and indentation."""
    result = []
    indent = 0
    in_string = None
    i = 0
    line_start = True
    
    while i < len(src):
        ch = src[i]
        
        # Handle string literals
        if in_string:
            result.append(ch)
            if ch == '\\':
                i += 1
                if i < len(src):
                    result.append(src[i])
            elif ch == in_string:
                in_string = None
            i += 1
            continue
        
        # Start of string
        if ch == '"' or ch == "'":
            in_string = ch
            result.append(ch)
            i += 1
            continue
        
        # Handle keywords that should be on new lines
        keywords_newline = ['local ', 'function ', 'if ', 'for ', 'while ', 
                           'repeat', 'end', 'else', 'elseif ', 'return', 'then', 'do']
        
        # Check if we need a newline
        need_newline = False
        for kw in keywords_newline:
            if src[i:i+len(kw)] == kw:
                # Special cases
                if kw == 'end':
                    indent = max(0, indent - 1)
                    need_newline = True
                elif kw in ['else', 'elseif']:
                    indent = max(0, indent - 1)
                    need_newline = True
                elif kw in ['local ', 'function ', 'if ', 'for ', 'while ', 'return']:
                    need_newline = True
                elif kw == 'then':
                    need_newline = True
                    indent += 1
                elif kw == 'do':
                    need_newline = True
                    indent += 1
                break
        
        # Also newline after ;
        if ch == ';' and not in_string:
            result.append(';\n')
            result.append('\t' * indent)
            i += 1
            continue
        
        # Add newline before keywords
        if need_newline and not line_start:
            result.append('\n')
            result.append('\t' * indent)
            line_start = True
        
        # Handle end keyword
        if src[i:i+3] == 'end' and (i+3 >= len(src) or not src[i+3].isalnum()):
            if not line_start:
                result.append('\n')
                result.append('\t' * max(0, indent - 1))
            result.append('end')
            i += 3
            line_start = False
            continue
        
        result.append(ch)
        line_start = False
        i += 1
    
    return ''.join(result)


def rename_all_obfuscated(src):
    """Rename all obfuscated variable names to readable ones."""
    renames = {
        # Services (already renamed)
        'GetService': 'GetService',
        'LocalPlayer': 'LocalPlayer',
        'PlayerGui': 'PlayerGui',
        'Workspace': 'Workspace',
        'ReplicatedStorage': 'ReplicatedStorage',
        'UserInputService': 'UserInputService',
        
        # Constants
        'WnZzNDxUzWNM': 'FOV_30_RAD',
        'IqZNvwmMq0xq': 'FOV_45_RAD',
        'bQnHb0zmnnW1Z_': 'FOV_42_RAD',
        'o0xuulOwqZzqoq': 'FOV_28_RAD',
        'OplO01_N': 'FOV_18_RAD',
        'DXxXZIHnb0H': 'FOV_72_RAD',
        'pznNWoQz': 'MIN_PITCH',
        'bNDqoQboMuHvq': 'MAX_PITCH',
        'HvQQ1qo1oqobx': 'GRAVITY',
        'HIDbOl1zlXQ': 'BALLISTIC_CACHE_FRAMES',
        'lZzozu1n': 'BALLISTIC_CACHE_DIST',
        'bOQbMlXUwwWx': 'MIN_TRAVEL_TIME',
        'HHn0OQb': 'ACQUIRE_FRAMES',
        
        # Main tables
        'LIB': 'LIB',
        'Config': 'Config',
        'State': 'State',
        'ItemIcons': 'ItemIcons',
        'UILib': 'UILib',
        'Version': 'Version',
        'AccentColor': 'AccentColor',
        'ESPFolder': 'ESPFolder',
        'UpdateTasks': 'UpdateTasks',
        'HubNames': 'HubNames',
        'BuildNumber': 'BuildNumber',
        
        # Functions
        'Notify': 'Notify',
        'GetItemIcon': 'GetItemIcon',
        'RegisterTask': 'RegisterTask',
        'GetPlayerRole': 'GetPlayerRole',
        'UpdatePlayerRole': 'UpdatePlayerRole',
        'AddPlayerESP': 'AddPlayerESP',
        'RemovePlayerESP': 'RemovePlayerESP',
        'UpdatePlayerESP': 'UpdatePlayerESP',
        'RefreshAllESP': 'RefreshAllESP',
        'UpdatePlayerState': 'UpdatePlayerState',
        'AddPlayerOutline': 'AddPlayerOutline',
        'UpdatePlayerOutline': 'UpdatePlayerOutline',
        'OnMapObjectAdded': 'OnMapObjectAdded',
        'OnMapObjectRemoved': 'OnMapObjectRemoved',
        'InitMapESP': 'InitMapESP',
        'SetupMapESP': 'SetupMapESP',
        'UpdateGenerator': 'UpdateGenerator',
        'ConnectGeneratorSignals': 'ConnectGeneratorSignals',
        'ConnectPalletSignals': 'ConnectPalletSignals',
        'SetGateGhost': 'SetGateGhost',
        'AddHighlight': 'AddHighlight',
        'RemoveHighlight': 'RemoveHighlight',
        'GetAttributeValue': 'GetAttributeValue',
        'IsDescendantOf': 'IsDescendantOf',
        'IsAttackButton': 'IsAttackButton',
        'HookAttackButton': 'HookAttackButton',
        'CreateBillboardLabel': 'CreateBillboardLabel',
        'RefreshObjectESP': 'RefreshObjectESP',
        'RefreshWindowESP': 'RefreshWindowESP',
        'AddWindowESP': 'AddWindowESP',
        'RemoveWindowESP': 'RemoveWindowESP',
        'FindWindowPart': 'FindWindowPart',
        'OnWindowAdded': 'OnWindowAdded',
        'GetSafeGuiParent': 'GetSafeGuiParent',
        
        # Camera Veil
        'EnableCameraVeil': 'EnableCameraVeil',
        'DisableCameraVeil': 'DisableCameraVeil',
        'SetupCameraVeilMobile': 'SetupCameraVeilMobile',
        'ResetCameraVeil': 'ResetCameraVeil',
        'CameraVeilUpdate': 'CameraVeilUpdate',
        'IsSpearMode': 'IsSpearMode',
        'IsHoldingSpear': 'IsHoldingSpear',
        'FindNearestSurvivor': 'FindNearestSurvivor',
        'GetHeadPosition': 'GetHeadPosition',
        'GetVelocity': 'GetVelocity',
        'GetOrigin': 'GetOrigin',
        'GetSpearSpeed': 'GetSpearSpeed',
        'SolveBallistic': 'SolveBallistic',
        'SolveBallisticToTarget': 'SolveBallisticToTarget',
        'SolveDirection': 'SolveDirection',
        'ScoreCandidate': 'ScoreCandidate',
        'ComputeLanding': 'ComputeLanding',
        'UpdateSnapLine': 'UpdateSnapLine',
        
        # Common parameter names
        'QUNQlx': 'title',
        'BDvbN_u': 'message',
        'QxXul': 'delay',
        'umOwmoO_pXlXNx': 'itemName',
        'B0Hlx_OxUw': 'taskName',
        'uNmqn': 'interval',
        'OOUxOlXnloupNo': 'callback',
        'OzmZnNxM': 'iconId',
        'B_xnoOlZlv_X': 'key',
        'w_XDu': 'value',
    }
    
    for old, new in renames.items():
        src = re.sub(r'\b' + re.escape(old) + r'\b', new, src)
    
    return src


def clean_dot_access(src):
    """Convert ['key'] to .key for cleaner code."""
    # Convert ["key"] to .key (but not for numeric indices)
    src = re.sub(r'\[\s*"(\w+)"\s*\]', r'.\1', src)
    # Convert ['key'] to .key
    src = re.sub(r"\[\s*'(\w+)'\s*\]", r'.\1', src)
    return src


def main():
    if len(sys.argv) < 3:
        print("Usage: deobfuscate_final.py <input.lua> <output.lua>")
        sys.exit(1)
    
    input_path = sys.argv[1]
    output_path = sys.argv[2]
    
    with open(input_path, 'r', errors='ignore') as f:
        src = f.read()
    
    print(f"[*] Loaded {len(src)} bytes")
    
    # Step 1: Fold all constants
    src = fold_all_constants(src)
    print("[*] Folded all constants")
    
    # Step 2: Clean dot access
    src = clean_dot_access(src)
    print("[*] Cleaned dot access")
    
    # Step 3: Rename all obfuscated variables
    src = rename_all_obfuscated(src)
    print("[*] Renamed all obfuscated variables")
    
    # Step 4: Format code
    src = format_code(src)
    print("[*] Formatted code")
    
    # Clean up empty lines
    src = re.sub(r'\n{3,}', '\n\n', src)
    src = re.sub(r' +\n', '\n', src)
    
    os.makedirs(os.path.dirname(output_path) if os.path.dirname(output_path) else '.', exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(src)
    
    print(f"[+] Written {len(src)} bytes to {output_path}")
    print(f"[+] Lines: {src.count(chr(10)) + 1}")


if __name__ == '__main__':
    main()
