// Main
// OpenPlanet entry points. Everything else is called from here.

void Update(float deltaTime) {
    quickChatStateMachine.CloseIfTimedOut();

    if (GameContext::IsInMenu()) {
        ResetAllState();
        return;
    }
    if (!IsPluginEnabled || !GameContext::IsChatAvailable()) return;

    array<PadDirection> pressedDirections = controllerButtonTracker.PollNewlyPressedDirections();
    for (uint i = 0; i < pressedDirections.Length; i++) {
        quickChatStateMachine.OnDirectionPressed(pressedDirections[i]);
    }
}

void Render() {
    ChatLogOverlay::Render();

    if (quickChatStateMachine.isAwaitingSlot) {
        QuickChatMenuOverlay::Render(quickChatStateMachine.openGroup);
    }
}

UI::InputBlocking OnKeyPress(bool isKeyDown, VirtualKey key) {
    PadDirection direction;

    if (!isKeyDown || !IsPluginEnabled) return UI::InputBlocking::DoNothing;

    if (GameContext::IsInMenu()) {
        ResetAllState();
        return UI::InputBlocking::DoNothing;
    }
    if (!GameContext::IsChatAvailable()) return UI::InputBlocking::DoNothing;
    if (!KeyboardInput::TryGetDirection(key, direction)) return UI::InputBlocking::DoNothing;

    lastUsedInputSource = InputSource::Keyboard;
    quickChatStateMachine.OnDirectionPressed(direction);

    return quickChatStateMachine.isAwaitingSlot ? UI::InputBlocking::Block : UI::InputBlocking::DoNothing;
}

void RenderMenu() {
    if (UI::MenuItem(Icons::Commenting + " RL Quick Chats", "", IsPluginEnabled)) {
        IsPluginEnabled = !IsPluginEnabled;
        OnSettingsChanged();
    }
}

void OnSettingsChanged() {
    if (!IsPluginEnabled) ResetAllState();
}

void ResetAllState() {
    quickChatStateMachine.ResetEverything();
    chatLog.Clear();
}
