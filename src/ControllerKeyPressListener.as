// Custom code to listen for Controller inputs, provided by:
//      https://github.com/XertroV/tm-camera-toggle.git

bool[] newButtonsPressed = array<bool>(16);
bool[] lastButtonsPressed = array<bool>(16);
bool[] nextButtonsPressed = array<bool>(16);

// array of (buttonIds, pressed)
//array<pair<uint, bool>> inputQueue = array<pair<uint, bool>>(16);
//pair<uint, bool>[] inputQueue = array<pair<uint, bool>>(16);

// Array of pressed buttonIds.
bool[] inputQueue = array<bool>(16);
bool[] emptyQueue = array<bool>(16);

/** Called every frame. `dt` is the delta time (milliseconds since last frame).
*/
bool[] UpdateControllerButtonStatus(float dt) {
//    print("updating...");
    auto app = GetApp();

    auto input = app.InputPort;

//    for (uint i = 0; i < inputQueue.Length; i++)
//    {
//            inputQueue[i] = false;
//    }

    for (uint i = 0; i < nextButtonsPressed.Length; i++) {
        nextButtonsPressed[i] = false;
    }

    //ToDo: see what buttons are being pressed.
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

    // update in the menu so settings preview of button presses works. but we don't want to try and toggle the camera in the menu
    if (app.CurrentPlayground is null) return emptyQueue;

//    CheckForTogglePress();

    return newButtonsPressed;
}

void UpdateButtonPressed(uint value, Button button) {
    nextButtonsPressed[button] = nextButtonsPressed[button] || value > 0;
//    if(nextButtonsPressed[button]){
//        print("Button pressed!");
//        print(button);
//    }
}

//uint toggleState = 0;

//void CheckForTogglePress() {
//    if (newButtonsPressed[S_Button]) {
//        // trace('toggling camera');
//        toggleState = (toggleState + 1) % uint(S_ToggleMode);
//        if (toggleState == 0) {
//            SetCamChoice(S_CameraA);
//        } else if (toggleState == 1) {
//            SetCamChoice(S_CameraB);
//        } else if (toggleState == 2) {
//            SetCamChoice(S_CameraC);
//        } else {
//            SetCamChoice(S_CameraA);
//            warn("Got toggle press but found an invalid toggleState: " + toggleState + " (should 0, 1, or 2)");
//        }
//    }
//}