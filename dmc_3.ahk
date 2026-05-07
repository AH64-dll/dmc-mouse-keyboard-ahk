; =============================================================================
; dmc_3.ahk  --  Devil May Cry 3 Special Edition  --  Mouse + Keyboard mapping
; Run alongside mouse_movement.ahk, both as Administrator.
; Toggle this script on/off with F7.
;
; Full DMC3 PC keyboard reference:
;   W/A/S/D      = Move character
;   Numpad 8/6/2/4 = Camera Up/Right/Down/Left (sent by mouse_movement.ahk)
;   Arrow Keys   = D-pad shortcuts (remapped below)
;   I            = Melee      (Triangle / Y)
;   J            = Shoot      (Square   / X)
;   K            = Jump       (Cross    / A)
;   L            = Style      (Circle   / B)
;   N            = Devil Trigger        (L1 / LB)
;   Space        = Lock-On             (R1 / RB)
;   Q            = Change Guns         (L2 / LT)
;   E            = Change Devil Arms   (R2 / RT)
;   O            = Change Target       (L3 / LS)
;   P            = Default Camera      (R3 / RS)
;   M            = Taunt               (Select / Back)
;   Escape       = Pause Menu          (Start)
;   1            = Item Screen         (D-pad Up)
;   2            = File Screen         (D-pad Left)
;   3            = Equip Screen        (D-pad Down)
;   4            = Map Screen          (D-pad Right)
; =============================================================================

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#HotkeyInterval 100
#MaxHotkeysPerInterval 99999

; --- Mouse button mapping ----------------------------------------------------
LButton::i          ; [Left Click]    Melee Attack     (Triangle / Y)
RButton::j          ; [Right Click]   Shoot            (Square   / X)
MButton::l          ; [Middle Click]  Style Action     (Circle   / B)
XButton1::q         ; [Mouse 4]       Change Guns      (L2 / LT)
XButton2::l         ; [Mouse 5]       Style Action     (Circle   / B)  same as MMB

; --- Keyboard remaps ---------------------------------------------------------
Space::k            ; [Space]         Jump             (Cross / A)
                    ;   Note: the game's real Space = Lock-On, remapped below
LShift::Space       ; [Left Shift]    Lock-On          (R1 / RB)
                    ;   Matches the lock-on key in mouse_movement.ahk so
                    ;   camera suppression and the in-game lock-on fire together

; --- Arrow keys -> D-pad numbers (top-row 1/2/3/4, NOT numpad) --------------
Up::
    Send 1
return
Right::
    Send 2
return
Down::
    Send 3
return
Left::
    Send 4
return

; --- Passthrough -------------------------------------------------------------
p::LButton          ; [P]             Real left-click passthrough (for menus)
; -----------------------------------------------------------------------------

; F7 toggles the whole script on/off
F7::
    Suspend
    if (A_IsSuspended)
        ToolTip, DMC3 Controls: DISABLED, 10, 40
    else
        ToolTip, DMC3 Controls: ENABLED, 10, 40
    SetTimer, RemoveToolTip, -1000
return

RemoveToolTip:
    ToolTip
return
