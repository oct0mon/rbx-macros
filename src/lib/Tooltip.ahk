#Requires AutoHotkey v2.0
#SingleInstance Force

ShowTooltip(message := "", duration := 2000) {
    SoundPlay '*64'
    ToolTip message
    SetTimer () => ToolTip(), duration
}
