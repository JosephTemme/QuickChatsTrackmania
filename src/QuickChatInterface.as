// ===== QuickChatInterface.as =====

// Global input block (toggle + runtime)
bool g_blockInput = false;

// Guard
bool IsPlaying() {
    auto app = GetApp();
    if (app is null) return false;
#if TMNEXT
    if (!Permissions::InGameChat()) return false;
    if (app.InputPort !is null && app.InputPort.CurrentActionMap == "MenuInputsMap") return false;
#endif
    auto pg = app.CurrentPlayground;
    if (pg is null) return false;
    return true;
}

// Power control hooks
void PowerOff() { g_blockInput = true; ClearQueues(); }
void PowerOn() {  g_blockInput = false; }

void OnSettingsChanged() {
    if (!Setting_Power) PowerOff();
    else PowerOn();
}
