// ===== Main.as =====

void Main() {}

void Update(float dt) {
    if (g_state.timedOut()) g_state.reset();
#if TMNEXT
    { auto app = GetApp(); if (app !is null && app.InputPort !is null && app.InputPort.CurrentActionMap == "MenuInputsMap") { ClearQueues(); return; } }
#endif
    if (!IsPlaying() || g_blockInput) return;
    bool[] pressed=UpdateControllerButtonStatus();
    for(uint i=0;i<pressed.Length;i++) { if(!pressed[i]) continue; int sel=SelectorIndexForButton(Button(i)); if(sel>0) HandleSelector(sel); }
}

void Render() {
    RenderLog();
    RenderToasts();
    if (g_state.waiting && g_state.group>=1) {
        if (Setting_UseRectHint) DrawHintRect(g_state.group);
        else DrawHintCross(g_state.group);
    }
}

UI::InputBlocking OnKeyPress(bool down, VirtualKey key) {
    if(!down || !Setting_Power || g_blockInput) return UI::InputBlocking::DoNothing;
#if TMNEXT
    { auto app = GetApp(); if (app !is null && app.InputPort !is null && app.InputPort.CurrentActionMap == "MenuInputsMap") { ClearQueues(); return UI::InputBlocking::DoNothing; } }
#endif
    if (!IsPlaying()) return UI::InputBlocking::DoNothing;
    int sel=SelectorIndexForKey(key);
    if(sel>0) { HandleSelector(sel); if(g_state.waiting) return UI::InputBlocking::Block; }
    return UI::InputBlocking::DoNothing;
}
