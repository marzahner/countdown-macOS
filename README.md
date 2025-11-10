# Countdown Menu Bar App

macOS menu bar countdown timer with 4h & 1h options.

## Build & Install

1. Open Terminal in extracted folder
2. Run: `xcodebuild -project CountdownMenuBar.xcodeproj -scheme CountdownMenuBar -configuration Release`
3. App built to: `build/Release/CountdownMenuBar.app`
4. Drag to Applications folder
5. Run app (menu bar icon appears)

## Usage

- Click menu bar icon
- Select "4h Countdown" or "1h Countdown"
- 1h option shows red tint on icon
- Time format:
  - Above 1h: "1h 23" (hours + minutes)
  - Below 1h: "46:12" (minutes:seconds)
- Click Quit to exit

## Requirements

- macOS 11.0+
- Xcode (to build)
