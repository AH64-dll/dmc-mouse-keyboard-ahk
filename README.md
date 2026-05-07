# dmc-mouse-keyboard-ahk
AutoHotkey scripts for playing old Devil May Cry games with mouse &amp; keyboard. Maps mouse movement to camera control via raw input, and remaps mouse buttons + keyboard keys to match the game's controller layout.

# 🎮 Devil May Cry — Mouse & Keyboard Controls (AutoHotkey)

Play the classic **Devil May Cry** games on PC using your mouse and keyboard — no controller needed.

Two AutoHotkey scripts work together to give you full control:

- **`mouse_movement.ahk`** — Translates raw mouse movement into camera control (Numpad keys)
- **`dmc_3.ahk`** — Remaps mouse buttons and keyboard keys to match the game's controller layout

> ✅ Compatible with Devil May Cry 1, 2, 3 (Special Edition), and other classic DMC titles on PC.

---

## ⚙️ Requirements

- Windows 10 / 11
- [AutoHotkey v1.1](https://www.autohotkey.com/) installed
- Any classic Devil May Cry game (PC)

---

## 🚀 How to Use

> **Both scripts must be run as Administrator**, otherwise they cannot send input to the game.

1. Right-click `mouse_movement.ahk` → **Run as administrator**
2. Right-click `dmc_3.ahk` → **Run as administrator**
3. Launch the game
4. Press **F8** to activate mouse camera control
5. Press **F7** to activate the button remaps (or they're on by default)

Both scripts will show a small on-screen message confirming they are active.

---

## 🕹️ Key Bindings

### Mouse Buttons

| Mouse Input | Action | Controller Equivalent |
|---|---|---|
| Left Click | Melee Attack | Triangle / Y |
| Right Click | Shoot | Square / X |
| Middle Click | Style Action | Circle / B |
| Mouse Button 4 | Change Guns | L2 / LT |
| Mouse Button 5 | Style Action | Circle / B |

### Keyboard

| Key | Action | Controller Equivalent |
|---|---|---|
| W / A / S / D | Move Character | Left Stick |
| Mouse Movement | Camera | Right Stick |
| Space | Jump | Cross / A |
| Left Shift | Lock-On | R1 / RB |
| I | Melee Attack | Triangle / Y |
| J | Shoot | Square / X |
| K | Jump | Cross / A |
| L | Style Action | Circle / B |
| N | Devil Trigger | L1 / LB |
| Q | Change Guns | L2 / LT |
| E | Change Devil Arms | R2 / RT |
| O | Change Target | L3 / LS |
| P | Default Camera | R3 / RS |
| M | Taunt | Select / Back |
| Escape | Pause Menu | Start |

### D-Pad / Menu Shortcuts

| Key | Action |
|---|---|
| Arrow Up | Item Screen |
| Arrow Right | File Screen |
| Arrow Down | Equip Screen |
| Arrow Left | Map Screen |

---

## 🔧 Toggle Keys

| Key | What it does |
|---|---|
| **F7** | Enable / Disable button remaps (`dmc_3.ahk`) |
| **F8** | Enable / Disable mouse camera control (`mouse_movement.ahk`) |

A tooltip will appear on screen confirming the current state whenever you toggle.

---

## ⚡ Mouse Camera Settings

You can tweak the camera feel by editing the config block at the top of `mouse_movement.ahk`:

```ahk
global CFG_TOGGLE_KEY   := "F8"    ; Key to toggle on/off
global CFG_LOCKON_KEY   := "Shift" ; Hold this to suppress camera while locking on
global CFG_THRESHOLD    := 8       ; Mouse sensitivity (higher = less sensitive)
global CFG_STOP_MS      := 80      ; Delay (ms) before camera stops after mouse stops
global CFG_START_ACTIVE := 0       ; Set to 1 to auto-enable on script launch
```

**Tips:**
- Increase `CFG_THRESHOLD` if the camera feels too twitchy
- Decrease `CFG_STOP_MS` if the camera feels like it lingers too long after you stop moving
- Set `CFG_START_ACTIVE := 1` if you want the mouse camera on as soon as you launch the script

---

## 📝 Notes

- Holding **Left Shift** (Lock-On) automatically suppresses camera movement so the view doesn't spin while you're locked onto an enemy.
- Press **P** in-game menus to send a real left mouse click (useful for navigating UI).
- Some key actions (e.g. Style, Devil Arms) may not apply to all DMC titles — they will simply do nothing if the game doesn't use that input.
- The scripts are independent — you can run one without the other if needed.

---

## 📁 Files

```
dmc-mouse-keyboard-ahk/
├── dmc_3.ahk            # Button & keyboard remapper
├── mouse_movement.ahk   # Mouse-to-camera translator
└── README.md
```
