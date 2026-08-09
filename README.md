# BOLONG-HUB

Deobfuscated version of BOLONG-HUB for Violence District (Roblox).

## Structure

```
BOLONG-HUB/
├── libs/
│   ├── b0lngUi.lua      # UI Library (clean)
│   └── loader.lua        # Main loader
├── scripts/
│   └── ViolenceDistrict.lua  # Deobfuscated game script
├── main/
│   ├── b0lngUi.lua      # Original UI Library
│   └── BOLONGHUB        # Original obfuscated loader
├── games/
│   └── ViolenceDistrict.lua  # Original obfuscated script
└── .github/workflows/
    └── deobfuscate-static.yml  # CI deobfuscation
```

## Usage

1. Copy `BOLONG-HUB` folder to your exploit workspace
2. Run: `loadstring(readfile("BOLONGHUB/libs/loader.lua"))()`

## Features

- ESP (players, generators, hooks, gates, pallets, windows)
- Camera Veil (auto-aim on survivors)
- Silent Aim
- Hitbox Expander
- Anti-Blind
- Ghost Gate
- Moonwalk
- Fullbright
- Auto Generator
- And more...

## Version

v4.1.1
