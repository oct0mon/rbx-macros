; Keybinds
; Toggle Anti Recoil: CTRL + F5

#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "../lib/Tooltip.ahk"

global IsActive := true
global Recoil := 2.0
global RecoilStep := 0.05
global RecoilStepInterval := 10

ToggleActive() {
    global IsActive := !IsActive

    ShowTooltip IsActive ? "AntiRecoil enabled" : "AntiRecoil disabled"
}

PreventRecoil() {
    if (!IsActive)
        return

    DllCall "mouse_event", "UInt", 0x0001, "UInt", 0, "UInt", Recoil, "UInt", 0, "UPtr", 0
    Sleep RecoilStepInterval
}

UpdateRecoil(change := 0) {
    if (Recoil - change <= 0)
        global Recoil := 0
    else
        global Recoil += change

    ShowTooltip "Recoil Strength: " . Format('{1:.2f}', Recoil), 1000
}

; In case both buttons are pressed at the same time and not one after the other
; mainly to prevent weird bugs
~RButton & ~LButton:: {
    while (GetKeyState("RButton", "P") && GetKeyState("LButton", "P"))
        PreventRecoil
}

~RButton:: {
    while (GetKeyState("RButton", "P")) {
        if (GetKeyState("LButton", "P"))
            PreventRecoil
        else
            Sleep RecoilStepInterval
    }
}

F10:: UpdateRecoil +RecoilStep
F9:: UpdateRecoil -RecoilStep

^F4:: ExitApp
^F5:: ToggleActive