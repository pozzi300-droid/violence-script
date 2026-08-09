#!/usr/bin/env python3
"""
Second-pass deobfuscator for ViolenceDistrict.lua
Cleans up: ENV calls, obfuscated variable names, constant folding
"""
import re
import sys
import os


def build_env_map(src):
    """Extract ENV table mapping: obfuscated_key -> real_module"""
    env_map = {}
    match = re.search(r'local\s+ENV\s*=\s*\{(.*?)\n\}', src, re.DOTALL)
    if not match:
        return env_map
    content = match.group(1)
    for m in re.finditer(r'\[\s*"(\w+)"\s*\]\s*=\s*(\w+)', content):
        key, val = m.group(1), m.group(2)
        env_map[key] = val
    return env_map


def replace_env_calls(src, env_map):
    """Replace ENV["key"] with actual module/function names."""
    def replacer(m):
        key = m.group(1)
        if key in env_map:
            return env_map[key]
        return m.group(0)

    # Replace ENV["key"] patterns with flexible whitespace
    src = re.sub(r'ENV\s*\[\s*"(\w+)"\s*\]', replacer, src)
    return src


def simplify_dot_calls(src):
    """Convert module["func"] to module.func where safe."""
    # Only simplify specific known safe patterns
    safe_replacements = [
        # Roblox Instance constructors
        (r'Instance\s*\[\s*"new"\s*\]', 'Instance.new'),
        # Vector3/Color3/etc constructors and methods
        (r'Vector3\s*\[\s*"new"\s*\]', 'Vector3.new'),
        (r'Vector3\s*\[\s*"fromRGB"\s*\]', 'Vector3.fromRGB'),
        (r'Color3\s*\[\s*"fromRGB"\s*\]', 'Color3.fromRGB'),
        (r'Color3\s*\[\s*"new"\s*\]', 'Color3.new'),
        (r'UDim2\s*\[\s*"new"\s*\]', 'UDim2.new'),
        (r'UDim2\s*\[\s*"fromOffset"\s*\]', 'UDim2.fromOffset'),
        (r'UDim\s*\[\s*"new"\s*\]', 'UDim.new'),
        (r'CFrame\s*\[\s*"new"\s*\]', 'CFrame.new'),
        (r'Enum\s*\[\s*"Font"\s*\]\s*\[\s*"GothamBold"\s*\]', 'Enum.Font.GothamBold'),
        (r'Enum\s*\[\s*"Font"\s*\]\s*\[\s*"GothamBlack"\s*\]', 'Enum.Font.GothamBlack'),
        # Standard library
        (r'math\s*\[\s*"clamp"\s*\]', 'math.clamp'),
        (r'math\s*\[\s*"abs"\s*\]', 'math.abs'),
        (r'math\s*\[\s*"max"\s*\]', 'math.max'),
        (r'math\s*\[\s*"min"\s*\]', 'math.min'),
        (r'math\s*\[\s*"floor"\s*\]', 'math.floor'),
        (r'math\s*\[\s*"rad"\s*\]', 'math.rad'),
        (r'math\s*\[\s*"deg"\s*\]', 'math.deg'),
        (r'math\s*\[\s*"cos"\s*\]', 'math.cos'),
        (r'math\s*\[\s*"sin"\s*\]', 'math.sin'),
        (r'math\s*\[\s*"acos"\s*\]', 'math.acos'),
        (r'math\s*\[\s*"atan2"\s*\]', 'math.atan2'),
        (r'math\s*\[\s*"huge"\s*\]', 'math.huge'),
        (r'table\s*\[\s*"insert"\s*\]', 'table.insert'),
        (r'table\s*\[\s*"remove"\s*\]', 'table.remove'),
        (r'table\s*\[\s*"pack"\s*\]', 'table.pack'),
        (r'table\s*\[\s*"unpack"\s*\]', 'table.unpack'),
        (r'string\s*\[\s*"format"\s*\]', 'string.format'),
        (r'string\s*\[\s*"find"\s*\]', 'string.find'),
        (r'string\s*\[\s*"lower"\s*\]', 'string.lower'),
        (r'string\s*\[\s*"byte"\s*\]', 'string.byte'),
        (r'string\s*\[\s*"char"\s*\]', 'string.char'),
        # Game service methods
        (r'game\s*\[\s*"GetService"\s*\]', 'game.GetService'),
        (r'game\s*\[\s*"HttpGet"\s*\]', 'game.HttpGet'),
    ]

    for pattern, replacement in safe_replacements:
        src = re.sub(pattern, replacement, src)

    return src


def fold_constants(src):
    """Simplify constant arithmetic expressions carefully."""
    # Only fold simple patterns that are clearly safe
    # Pattern: (num op num) where result is reasonable
    def fold_simple(m):
        a, op, b = int(m.group(1)), m.group(2), int(m.group(3))
        if op == '+':
            result = a + b
        elif op == '-':
            result = a - b
        elif op == '*':
            result = a * b
        elif op == '/':
            if b == 0:
                return m.group(0)
            result = a / b
            if result == int(result):
                result = int(result)
            else:
                return m.group(0)
        else:
            return m.group(0)

        # Only fold if result is reasonable (not too large/negative for UI)
        if -10000 <= result <= 10000:
            return str(result)
        return m.group(0)

    # Match (num op num) with optional spaces
    src = re.sub(r'\(\s*(-?\d+)\s*([+\-*/])\s*(-?\d+)\s*\)', fold_simple, src)
    return src


def rename_variables(src):
    """Rename known obfuscated variable names to readable ones."""
    renames = {
        # Main state table
        'HM1uHIZZl0': 'State',
        # Player references
        'Hnv0Zw': 'LocalPlayer',
        'lXUHZ': 'PlayerGui',
        # Services
        'HWvNq': 'VirtualInputManager',
        'pvIzmpOMQ': 'VirtualUser',
        'D1xooONpx': 'GuiService',
        'qxUnN': 'Lighting',
        'BUb0O1q': 'Stats',
        'uvWUOOzvx1': 'Workspace',
        'DMNlwumvQ0Mmvp': 'ReplicatedStorage',
        'WoxXzobD': 'CollectionService',
        'OqbbHwQNoU': 'UserInputService',
        # Config/UI
        'B0mzDm1QO': 'UILib',
        'uHbIpwDDHx': 'Version',
        'bH0vx': 'AccentColor',
        # Camera veil functions
        'IbxMMx1lp': 'EnableCameraVeil',
        'wm_0lW': 'DisableCameraVeil',
        'DvpWoQQ0pQ_1': 'SetupCameraVeilMobile',
        'qW1lMWN': 'ResetCameraVeil',
        'bnXb_qOXXuw': 'CameraVeilUpdate',
        'qwIwXO_vlnv': 'IsSpearMode',
        'wlwzz': 'IsHoldingSpear',
        'NWbUwz_UNw': 'FindNearestSurvivor',
        'Q0mnQUbb1__u': 'GetHeadPosition',
        'OX_lDUl0QzzoNb': 'GetVelocity',
        'Mp_0M0': 'GetOrigin',
        'NHbINz': 'GetSpearSpeed',
        'Npuqux': 'SolveBallistic',
        'HI_0HovXQm1Z': 'SolveBallisticToTarget',
        'IUUq_nZXqZ': 'SolveDirection',
        'oQQXvbHmD': 'ScoreCandidate',
        'OQlbQ0ONxDoOo': 'ComputeLanding',
        # ESP functions
        'HxW0NlvXwXHIqQ': 'AddPlayerESP',
        'MXwU1D0': 'RemovePlayerESP',
        'ozoHvMX1wbMNu': 'UpdatePlayerESP',
        'uQmbzH_zOzIX': 'RefreshAllESP',
        'W1NH1ZnM_1m': 'UpdatePlayerState',
        'wxouub': 'AddPlayerOutline',
        'Oqpmb': 'UpdatePlayerOutline',
        # Map object functions
        'ppW0q': 'OnMapObjectAdded',
        'HHmlDn_O': 'OnMapObjectRemoved',
        'oQQXp00u1nHQ': 'InitMapESP',
        'ul0ZZMWZ': 'SetupMapESP',
        # Generator functions
        'bp0wImow0Dm': 'UpdateGenerator',
        'qnDOw': 'ConnectGeneratorSignals',
        # Pallet functions
        'HH1mn0WxUXD_Q': 'ConnectPalletSignals',
        'wz0qHHnO': 'SetGateGhost',
        # Highlight functions
        'buHOpx0lv': 'AddHighlight',
        'onHbZx': 'RemoveHighlight',
        # Role functions
        'vWlM1ZWQubmZp': 'GetPlayerRole',
        'oHpnQZpOMIO0n': 'UpdatePlayerRole',
        # Misc
        'QwZOO1pHbl1_': 'ESPFolder',
        'IWzQn': 'UpdateTasks',
        'NpvQIDpz': 'RegisterTask',
        'omWzxqom': 'HookTaskDelay',
        'oWUuXq_pI1wWX': 'UnhookTaskDelay',
        'poOUloUDHH': 'GetItemIcon',
        'vUuMpXWnnp': 'ItemIcons',
        'bZ0Z0M': 'HubNames',
        'ulUmWDQmqmmv': 'BuildNumber',
        # Window ESP
        'vzZWmwZvppv': 'AddWindowESP',
        'DnqX_lbNxO': 'RemoveWindowESP',
        'NIxZZvbqZwu': 'FindWindowPart',
        'Mm1nMo_pQD': 'OnWindowAdded',
        'uDUDl_': 'RefreshWindowESP',
        # Misc helpers
        'wmbMHDw_': 'GetAttributeValue',
        'IQ__boUwo': 'IsDescendantOf',
        'IN11Xq0I1xXxZ': 'IsAttackButton',
        'InDmQ': 'HookAttackButton',
        'BQ_XUlH0N': 'UpdateSnapLine',
        'uZZQq': 'GetSafeGuiParent',
        'Q1wIOIZ0mONH': 'CreateBillboardLabel',
        'bbQbmv1MbH': 'RefreshObjectESP',
    }

    for old, new in renames.items():
        src = re.sub(r'\b' + re.escape(old) + r'\b', new, src)

    return src


def remove_env_table(src):
    """Remove the ENV table definition since it's been inlined."""
    match = re.search(r'local\s+ENV\s*=\s*\{.*?\n\}', src, re.DOTALL)
    if match:
        src = src[:match.start()] + '-- [ENV table inlined]\n' + src[match.end():]
    return src


def main():
    if len(sys.argv) < 3:
        print("Usage: deobfuscate_pass2.py <input.lua> <output.lua>")
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    with open(input_path, 'r', errors='ignore') as f:
        src = f.read()

    print(f"[*] Loaded {len(src)} bytes")

    # Step 1: Build ENV map and replace calls
    env_map = build_env_map(src)
    print(f"[*] ENV map: {len(env_map)} entries")
    for k, v in env_map.items():
        print(f"    {k} -> {v}")

    src = replace_env_calls(src, env_map)
    print("[*] Replaced ENV calls")

    # Step 2: Remove ENV table
    src = remove_env_table(src)
    print("[*] Removed ENV table")

    # Step 3: Simplify dot calls
    src = simplify_dot_calls(src)
    print("[*] Simplified dot calls")

    # Step 4: Fold constants
    src = fold_constants(src)
    print("[*] Folded constants")

    # Step 5: Rename variables
    src = rename_variables(src)
    print("[*] Renamed variables")

    os.makedirs(os.path.dirname(output_path) if os.path.dirname(output_path) else '.', exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(src)

    print(f"[+] Written {len(src)} bytes to {output_path}")


if __name__ == '__main__':
    main()
