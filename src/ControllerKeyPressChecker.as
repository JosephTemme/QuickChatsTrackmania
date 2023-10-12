/* Custom code to listen for Controller inputs.
* Skeleton provided by:      https://github.com/XertroV/tm-camera-toggle.git
* Further modified by Joey Temme.
*/
bool[] emptyQueue = array<bool>(16);

bool[] newButtonsPressed = array<bool>(16);
bool[] lastButtonsPressed = array<bool>(16);
bool[] nextButtonsPressed = array<bool>(16);

// Find which controller buttons are pressed.
bool[] UpdateControllerButtonStatus(float dt) {
    auto app = GetApp();

    auto input = app.InputPort;

    for (uint i = 0; i < nextButtonsPressed.Length; i++) {
        nextButtonsPressed[i] = false;
    }

    for (uint i = 0; i < input.Script_Pads.Length; i++) {
        auto pad = input.Script_Pads[i];
        if (pad.Type >= 2)
        {
            UpdateButtonPressed(pad.Left, Button::Left);
            UpdateButtonPressed(pad.Right, Button::Right);
            UpdateButtonPressed(pad.Up, Button::Up);
            UpdateButtonPressed(pad.Down, Button::Down);
            UpdateButtonPressed(pad.A, Button::A);
            UpdateButtonPressed(pad.B, Button::B);
            UpdateButtonPressed(pad.X, Button::X);
            UpdateButtonPressed(pad.Y, Button::Y);
            UpdateButtonPressed(pad.L1, Button::L1);
            UpdateButtonPressed(pad.L2 > 0 ? 1 : 0, Button::L2);
            UpdateButtonPressed(pad.LeftStickBut, Button::L3);
            UpdateButtonPressed(pad.R1, Button::R1);
            UpdateButtonPressed(pad.R2 > 0 ? 1 : 0, Button::R2);
            UpdateButtonPressed(pad.RightStickBut, Button::R3);
            UpdateButtonPressed(pad.Menu, Button::Menu);
            UpdateButtonPressed(pad.View, Button::View);
        }
    }

    for (uint i = 0; i < newButtonsPressed.Length; i++) {
        newButtonsPressed[i] = !lastButtonsPressed[i] && nextButtonsPressed[i];
        lastButtonsPressed[i] = nextButtonsPressed[i];
    }

    if (app.CurrentPlayground is null) return emptyQueue;

    return newButtonsPressed;
}

void UpdateButtonPressed(uint value, Button button) {
    nextButtonsPressed[button] = nextButtonsPressed[button] || value > 0;
}
