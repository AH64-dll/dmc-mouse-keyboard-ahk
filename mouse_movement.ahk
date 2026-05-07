; =============================================================================
; mouse_movement.ahk  --  Mouse -> Numpad Keys for Devil May Cry 3
; Run this script as Administrator or it cannot send input to the game!
; =============================================================================

#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%

; ===== CONFIG ================================================================
global CFG_TOGGLE_KEY   := "F8"    ; F8 toggles on/off
global CFG_LOCKON_KEY   := "Shift" ; Holding this suppresses camera movement
global CFG_THRESHOLD    := 8       ; Raw mouse delta needed to move a direction
global CFG_STOP_MS      := 80      ; ms of stillness before numpad keys release
global CFG_START_ACTIVE := 0       ; 1 = active as soon as the script launches
; =============================================================================

; --- State -------------------------------------------------------------------
global g_Active       := CFG_START_ACTIVE
global g_LockOn       := 0
global g_LastMoveTime := 0
global g_Keys         := {Up:0, Down:0, Left:0, Right:0}

; --- Tray --------------------------------------------------------------------
Menu, Tray, NoStandard
Menu, Tray, Add, Toggle on/off (F8), ToggleActive
Menu, Tray, Add, Exit, ExitScript
Menu, Tray, Tip, DMC3 Mouse-to-Numpad

; --- Hotkeys -----------------------------------------------------------------
Hotkey, % CFG_TOGGLE_KEY,                ToggleActive
Hotkey, % "~" . CFG_LOCKON_KEY,          LockOnDown
Hotkey, % "~" . CFG_LOCKON_KEY . " up", LockOnUp

; --- Start raw input tracking ------------------------------------------------
global g_MD := new MouseDelta(Func("OnMouseMove"))
g_MD.Start()

; --- Watchdog timer ----------------------------------------------------------
SetTimer, Watchdog, 50

; --- Startup message ---------------------------------------------------------
ShowMsg(g_Active ? "Mouse ON  --  F8 to toggle" : "Mouse OFF  --  F8 to toggle")

return  ; AUTO-EXECUTE ENDS HERE. Labels below do NOT run on startup.
; =============================================================================


; =============================================================================
; TIMER: releases numpad keys when the mouse stops moving
; =============================================================================
Watchdog:
    if (g_Active && !g_LockOn && (A_TickCount - g_LastMoveTime > CFG_STOP_MS))
        ReleaseAll()
return


; =============================================================================
; HOTKEY LABELS
; =============================================================================
ToggleActive:
    g_Active := !g_Active
    if (!g_Active)
        ReleaseAll()
    ShowMsg(g_Active ? "Mouse ON  --  F8 to toggle" : "Mouse OFF  --  F8 to toggle")
return

LockOnDown:
    g_LockOn := 1
    ReleaseAll()
return

LockOnUp:
    g_LockOn := 0
    g_LastMoveTime := 0
return

ExitScript:
    ReleaseAll()
    ExitApp
return

HideMsg:
    Gui, Msg:Destroy
return


; =============================================================================
; FUNCTION: Called on every raw mouse movement event
; =============================================================================
OnMouseMove(device, dx, dy) {
    global g_Active, g_LockOn, CFG_THRESHOLD, g_LastMoveTime, g_Keys

    if (!g_Active || g_LockOn)
        return

    g_LastMoveTime := A_TickCount

    ; Horizontal
    if (dx > CFG_THRESHOLD) {
        if (g_Keys.Left) {
            SendEvent {Numpad4 up}
            g_Keys.Left := 0
        }
        if (!g_Keys.Right) {
            SendEvent {Numpad6 down}
            g_Keys.Right := 1
        }
    } else if (dx < -CFG_THRESHOLD) {
        if (g_Keys.Right) {
            SendEvent {Numpad6 up}
            g_Keys.Right := 0
        }
        if (!g_Keys.Left) {
            SendEvent {Numpad4 down}
            g_Keys.Left := 1
        }
    }

    ; Vertical
    if (dy > CFG_THRESHOLD) {
        if (g_Keys.Up) {
            SendEvent {Numpad8 up}
            g_Keys.Up := 0
        }
        if (!g_Keys.Down) {
            SendEvent {Numpad2 down}
            g_Keys.Down := 1
        }
    } else if (dy < -CFG_THRESHOLD) {
        if (g_Keys.Down) {
            SendEvent {Numpad2 up}
            g_Keys.Down := 0
        }
        if (!g_Keys.Up) {
            SendEvent {Numpad8 down}
            g_Keys.Up := 1
        }
    }
}


; =============================================================================
; FUNCTION: Release all numpad keys
; =============================================================================
ReleaseAll() {
    global g_Keys
    SendEvent {Numpad8 up}{Numpad2 up}{Numpad4 up}{Numpad6 up}
    g_Keys.Up := 0
    g_Keys.Down := 0
    g_Keys.Left := 0
    g_Keys.Right := 0
}


; =============================================================================
; FUNCTION: On-screen status message for 2 seconds
; =============================================================================
ShowMsg(text) {
    Gui, Msg:Destroy
    Gui, Msg:New, -Caption +AlwaysOnTop +ToolWindow
    Gui, Msg:Font, s11 bold
    Gui, Msg:Color, 111111
    Gui, Msg:Add, Text, cLime w240, %text%
    Gui, Msg:Show, NoActivate x10 y10
    SetTimer, HideMsg, -2000
}


; =============================================================================
; CLASS: MouseDelta -- captures raw mouse input via WM_INPUT
; =============================================================================
Class MouseDelta {
    State := 0

    __New(callback) {
        this.MouseMovedFn := this.MouseMoved.Bind(this)
        this.Callback     := callback
    }

    Start() {
        static DevSize := 8 + A_PtrSize, RIDEV_INPUTSINK := 0x00000100
        VarSetCapacity(RAWINPUTDEVICE, DevSize)
        NumPut(1,               RAWINPUTDEVICE, 0, "UShort")
        NumPut(2,               RAWINPUTDEVICE, 2, "UShort")
        NumPut(RIDEV_INPUTSINK, RAWINPUTDEVICE, 4, "Uint")
        ; Named GUI so it does not conflict with the status message GUI
        Gui, RawInputSink:+hwndhwnd
        NumPut(hwnd, RAWINPUTDEVICE, 8, "UPtr")
        this.RAWINPUTDEVICE := RAWINPUTDEVICE
        DllCall("RegisterRawInputDevices", "Ptr", &RAWINPUTDEVICE, "UInt", 1, "UInt", DevSize)
        OnMessage(0x00FF, this.MouseMovedFn)
        this.State := 1
        return this
    }

    Stop() {
        static RIDEV_REMOVE := 0x00000001, DevSize := 8 + A_PtrSize
        OnMessage(0x00FF, this.MouseMovedFn, 0)
        RAWINPUTDEVICE := this.RAWINPUTDEVICE
        NumPut(RIDEV_REMOVE, RAWINPUTDEVICE, 4, "Uint")
        DllCall("RegisterRawInputDevices", "Ptr", &RAWINPUTDEVICE, "UInt", 1, "UInt", DevSize)
        this.State := 0
        return this
    }

    Delete() {
        this.Stop()
        this.MouseMovedFn := ""
    }

    MouseMoved(wParam, lParam) {
        Critical
        static iSize := 0, sz := 0, pcbSize := 8 + 2*A_PtrSize
        static offsets := {x: 20 + A_PtrSize*2, y: 24 + A_PtrSize*2}, uRawInput

        VarSetCapacity(header, pcbSize, 0)
        if (!DllCall("GetRawInputData", "UPtr", lParam, "UInt", 0x10000005
                    , "UPtr", &header, "UInt*", pcbSize, "UInt", pcbSize) || ErrorLevel)
            return 0

        ThisMouse := NumGet(header, 8, "UPtr")

        if (!iSize) {
            DllCall("GetRawInputData", "UPtr", lParam, "UInt", 0x10000003
                  , "Ptr", 0, "UInt*", iSize, "UInt", 8 + A_PtrSize*2)
            VarSetCapacity(uRawInput, iSize)
        }
        sz := iSize
        DllCall("GetRawInputData", "UPtr", lParam, "UInt", 0x10000003
              , "Ptr", &uRawInput, "UInt*", sz, "UInt", 8 + A_PtrSize*2)

        x := NumGet(&uRawInput, offsets.x, "Int")
        y := NumGet(&uRawInput, offsets.y, "Int")

        this.Callback.(ThisMouse, x, y)
    }
}
