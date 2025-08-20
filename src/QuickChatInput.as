// ===== QuickChatInput.as =====

// Last input source: 0 = keyboard, 1 = controller
int g_lastInput = 0;

// Labels
string BtnLabelKeyboard(int selector) {
    VirtualKey vk = Setting_QuickChat1Binding;
    if (selector == 1) vk = Setting_QuickChat1Binding;
    else if (selector == 2) vk = Setting_QuickChat2Binding;
    else if (selector == 3) vk = Setting_QuickChat3Binding;
    else if (selector == 4) vk = Setting_QuickChat4Binding;
    return KeyName(vk);
}
string BtnLabelController(int selector) {
    if (selector == 1) return "Up";
    if (selector == 2) return "Left";
    if (selector == 3) return "Right";
    if (selector == 4) return "Down";
    return "?";
}
string KeyName(VirtualKey k) {
    if (k >= VirtualKey::A && k <= VirtualKey::Z) { int offset = int(k) - int(VirtualKey::A); return "" + string("ABCDEFGHIJKLMNOPQRSTUVWXYZ").SubStr(offset, 1); }
    if (k == VirtualKey::Up) return "Up";
    if (k == VirtualKey::Left) return "Left";
    if (k == VirtualKey::Right) return "Right";
    if (k == VirtualKey::Down) return "Down";
    if (k == VirtualKey::Space) return "Space";
    if (k == VirtualKey::Return) return "Enter";
    if (k == VirtualKey::Tab) return "Tab";
    return "#" + tostring(int(k));
}

// Controller poller
bool[] emptyQueue = array<bool>(16), newButtonsPressed = array<bool>(16), lastButtonsPressed = array<bool>(16), nextButtonsPressed = array<bool>(16);
bool[] UpdateControllerButtonStatus() {
    auto app = GetApp(); auto input = app.InputPort;
    for (uint i = 0; i < nextButtonsPressed.Length; i++) nextButtonsPressed[i] = false;
    for (uint i = 0; i < input.Script_Pads.Length; i++) {
        auto p = input.Script_Pads[i]; if (p.Type < 2) continue;
        UpdateButtonPressed(p.Left, Button::Left); UpdateButtonPressed(p.Right, Button::Right);
        UpdateButtonPressed(p.Up, Button::Up);     UpdateButtonPressed(p.Down, Button::Down);
        UpdateButtonPressed(p.A, Button::A);       UpdateButtonPressed(p.B, Button::B);
        UpdateButtonPressed(p.X, Button::X);       UpdateButtonPressed(p.Y, Button::Y);
        UpdateButtonPressed(p.L1, Button::L1);     UpdateButtonPressed(p.L2 > 0 ? 1 : 0, Button::L2);
        UpdateButtonPressed(p.LeftStickBut, Button::L3);
        UpdateButtonPressed(p.R1, Button::R1);     UpdateButtonPressed(p.R2 > 0 ? 1 : 0, Button::R2);
        UpdateButtonPressed(p.RightStickBut, Button::R3);
        UpdateButtonPressed(p.Menu, Button::Menu); UpdateButtonPressed(p.View, Button::View);
    }
    for (uint i = 0; i < newButtonsPressed.Length; i++) { newButtonsPressed[i] = !lastButtonsPressed[i] && nextButtonsPressed[i]; lastButtonsPressed[i] = nextButtonsPressed[i]; }
    if (app.CurrentPlayground is null) return emptyQueue; return newButtonsPressed;
}
void UpdateButtonPressed(uint v, Button b) { nextButtonsPressed[b] = nextButtonsPressed[b] || v > 0; if (v > 0) g_lastInput = 1; }

// Mapping helpers
int SelectorIndexForKey(VirtualKey k) {
    if (k == Setting_QuickChat1Binding) { g_lastInput = 0; return 1; }
    if (k == Setting_QuickChat2Binding) { g_lastInput = 0; return 2; }
    if (k == Setting_QuickChat3Binding) { g_lastInput = 0; return 3; }
    if (k == Setting_QuickChat4Binding) { g_lastInput = 0; return 4; }
    return 0;
}
int SelectorIndexForButton(Button b) {
    if (b == Setting_QuickChat5Binding) return 1;
    if (b == Setting_QuickChat6Binding) return 2;
    if (b == Setting_QuickChat7Binding) return 3;
    if (b == Setting_QuickChat8Binding) return 4;
    return 0;
}
int SlotForSelector(int selectorIndex) {
    if (selectorIndex == 2) return 0;
    if (selectorIndex == 1) return 1;
    if (selectorIndex == 3) return 2;
    if (selectorIndex == 4) return 3;
    return 0;
}
