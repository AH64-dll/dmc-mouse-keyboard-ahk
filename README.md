# 🎮 Devil May Cry — Mouse & Keyboard Controls (AutoHotkey)

Play the classic **Devil May Cry** games on PC using your mouse and keyboard — no controller needed.

Two AutoHotkey scripts work together to give you full control:

- **`mouse_movement.ahk`** — Translates raw mouse movement into camera control via Numpad keys
- **`dmc_3.ahk`** — Remaps mouse buttons and keyboard keys to match the game's controller layout

> ✅ Compatible with Devil May Cry 1, 2, 3 (Special Edition), and other classic DMC titles on PC.

---

## ⚙️ Requirements

- Windows 10 / 11
- [AutoHotkey v1.1](https://www.autohotkey.com/) installed
- Any classic Devil May Cry game (PC)

---

## 🚀 How to Use

> ⚠️ **Both scripts must be run as Administrator**, otherwise they cannot send input to the game.

1. Right-click `mouse_movement.ahk` → **Run as administrator**
2. Right-click `dmc_3.ahk` → **Run as administrator**
3. Launch the game
4. Press **F8** to activate mouse camera control
5. Press **F7** to activate the button remaps

Both scripts will show a small on-screen message confirming they are active. You can toggle them on or off at any time without restarting the game.

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

> 💡 Some actions (e.g. Style, Devil Arms, Devil Trigger) may not exist in all DMC titles — those keys will simply have no effect if the game doesn't use them.

---

## 🔧 Toggle Keys

| Key | Script | What it does |
|---|---|---|
| **F7** | `dmc_3.ahk` | Enable / Disable all button remaps |
| **F8** | `mouse_movement.ahk` | Enable / Disable mouse camera control |

An on-screen tooltip will confirm the current state whenever you press a toggle key.

### 🔁 Changing the Toggle Keys

Don't want to use F7 or F8? You can change them to any key you prefer.

**To change F8 (mouse camera toggle):**

Open `mouse_movement.ahk` in any text editor and find this line near the top:

```ahk
global CFG_TOGGLE_KEY := "F8"
```

Replace `"F8"` with your preferred key. Examples:

```ahk
global CFG_TOGGLE_KEY := "F6"   ; Use F6 instead
global CFG_TOGGLE_KEY := "F9"   ; Use F9 instead
global CFG_TOGGLE_KEY := "F10"  ; Use F10 instead
```

**To change F7 (button remap toggle):**

Open `dmc_3.ahk` in any text editor and find this line near the bottom:

```ahk
F7::
```

Replace `F7` with your preferred key. Examples:

```ahk
F6::    ; Use F6 instead
F9::    ; Use F9 instead
F10::   ; Use F10 instead
```

> ⚠️ Make sure the two scripts don't share the same toggle key, otherwise pressing it will trigger both at the same time.

> 💡 A full list of valid AHK key names (F1–F24, Numpad keys, etc.) can be found in the [AutoHotkey Key List](https://www.autohotkey.com/docs/v1/KeyList.htm).

---

## ⚡ Mouse Camera Settings

You can fine-tune the camera feel by editing the config block at the top of `mouse_movement.ahk`:

```ahk
global CFG_TOGGLE_KEY   := "F8"    ; Key to toggle camera on/off
global CFG_LOCKON_KEY   := "Shift" ; Hold this to suppress camera while locking on
global CFG_THRESHOLD    := 8       ; Mouse sensitivity (higher = less sensitive)
global CFG_STOP_MS      := 80      ; Delay (ms) before camera stops after mouse stops
global CFG_START_ACTIVE := 0       ; Set to 1 to auto-enable on script launch
```

| Setting | What to do |
|---|---|
| `CFG_THRESHOLD` | Increase if the camera feels too twitchy; decrease for more responsiveness |
| `CFG_STOP_MS` | Decrease if the camera lingers too long after you stop moving the mouse |
| `CFG_START_ACTIVE` | Set to `1` to have the mouse camera active as soon as the script launches |
| `CFG_LOCKON_KEY` | Change this if you remap your Lock-On key, so camera suppression still works |

---

## 📝 Notes

- Holding **Left Shift** (Lock-On) automatically suppresses camera movement so the view doesn't spin while locked onto an enemy. If you change the Lock-On key in-game, update `CFG_LOCKON_KEY` in `mouse_movement.ahk` to match.
- Press **P** to send a real left mouse click — useful for navigating in-game menus when the remaps are active.
- The two scripts are independent. You can run just `mouse_movement.ahk` for camera control only, or just `dmc_3.ahk` for button remaps only.
- If the scripts stop working after a Windows update, try right-clicking and running as Administrator again.

---

## 📁 Files

```
dmc-mouse-keyboard-ahk/
├── dmc_3.ahk            # Button & keyboard remapper
├── mouse_movement.ahk   # Mouse-to-camera translator
└── README.md
```
