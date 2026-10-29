// InputBindings
// Turns keyboard keys and controller buttons into pad directions
// (Up, Left, Right, Down), and remembers which device was used last.

InputSource lastUsedInputSource = InputSource::Keyboard;
ControllerButtonTracker controllerButtonTracker;
const int PadDirectionCount = 4;

enum InputSource { Keyboard, Controller }

enum PadDirection { Up, Left, Right, Down }

enum ControllerButton { Left = 0, Right, Up, Down, A, B, X, Y, L1, L2, L3, R1, R2, R3, Menu, View }

namespace KeyboardInput {
    bool TryGetDirection(VirtualKey key, PadDirection &out direction) {
        for (int i = 0; i < PadDirectionCount; i++) {
            PadDirection candidate = PadDirection(i);

            if (key == BindingFor(candidate)) {
                direction = candidate;
                return true;
            }
        }
        return false;
    }

    VirtualKey BindingFor(PadDirection direction) {
        if (direction == PadDirection::Up) return KeyboardBindingUp;
        if (direction == PadDirection::Left) return KeyboardBindingLeft;
        if (direction == PadDirection::Right) return KeyboardBindingRight;
        return KeyboardBindingDown;
    }

    string LabelFor(PadDirection direction) {
        return KeyName(BindingFor(direction));
    }

    string KeyName(VirtualKey key) {
        if (key >= VirtualKey::A && key <= VirtualKey::Z) {
            int letterIndex = int(key) - int(VirtualKey::A);
            return string("ABCDEFGHIJKLMNOPQRSTUVWXYZ").SubStr(letterIndex, 1);
        }
        if (key == VirtualKey::Up) return "Up";
        if (key == VirtualKey::Down) return "Down";
        if (key == VirtualKey::Left) return "Left";
        if (key == VirtualKey::Right) return "Right";
        if (key == VirtualKey::Space) return "Space";
        if (key == VirtualKey::Return) return "Enter";
        if (key == VirtualKey::Tab) return "Tab";
        return "#" + tostring(int(key));
    }
}

namespace ControllerInput {
    string LabelFor(PadDirection direction) {
        return ButtonName(controllerButtonTracker.BindingFor(direction));
    }

    string ButtonName(ControllerButton button) {
        if (button == ControllerButton::Left) return "Left";
        if (button == ControllerButton::Right) return "Right";
        if (button == ControllerButton::Up) return "Up";
        if (button == ControllerButton::Down) return "Down";
        if (button == ControllerButton::A) return "A";
        if (button == ControllerButton::B) return "B";
        if (button == ControllerButton::X) return "X";
        if (button == ControllerButton::Y) return "Y";
        if (button == ControllerButton::L1) return "L1";
        if (button == ControllerButton::L2) return "L2";
        if (button == ControllerButton::L3) return "L3";
        if (button == ControllerButton::R1) return "R1";
        if (button == ControllerButton::R2) return "R2";
        if (button == ControllerButton::R3) return "R3";
        if (button == ControllerButton::Menu) return "Menu";
        return "View";
    }
}

class ControllerButtonTracker {
    array<bool> isDown;
    array<bool> wasDownLastFrame;

    ControllerButtonTracker() {
        uint buttonCount = uint(ControllerButton::View) + 1;
        isDown = array<bool>(buttonCount);
        wasDownLastFrame = array<bool>(buttonCount);
    }

    array<PadDirection> PollNewlyPressedDirections() {
        array<PadDirection> newlyPressedDirections;

        ReadCurrentButtonStates();

        for (uint i = 0; i < isDown.Length; i++) {
            bool isNewPress = isDown[i] && !wasDownLastFrame[i];
            PadDirection direction;

            wasDownLastFrame[i] = isDown[i];

            if (isNewPress && TryGetDirection(ControllerButton(i), direction)) {
                newlyPressedDirections.InsertLast(direction);
            }
        }
        return newlyPressedDirections;
    }

    // Any held controller button counts as the player having switched to the controller.
    void ReadCurrentButtonStates() {
        auto inputPort = GetApp().InputPort;

        for (uint i = 0; i < isDown.Length; i++) {
            isDown[i] = false;
        }
        if (inputPort is null) return;

        for (uint i = 0; i < inputPort.Script_Pads.Length; i++) {
            auto pad = inputPort.Script_Pads[i];
            if (pad.Type < 2) continue;

            MarkIfPressed(pad.Left, ControllerButton::Left);
            MarkIfPressed(pad.Right, ControllerButton::Right);
            MarkIfPressed(pad.Up, ControllerButton::Up);
            MarkIfPressed(pad.Down, ControllerButton::Down);
            MarkIfPressed(pad.A, ControllerButton::A);
            MarkIfPressed(pad.B, ControllerButton::B);
            MarkIfPressed(pad.X, ControllerButton::X);
            MarkIfPressed(pad.Y, ControllerButton::Y);
            MarkIfPressed(pad.L1, ControllerButton::L1);
            MarkIfPressed(pad.L2 > 0 ? 1 : 0, ControllerButton::L2);
            MarkIfPressed(pad.LeftStickBut, ControllerButton::L3);
            MarkIfPressed(pad.R1, ControllerButton::R1);
            MarkIfPressed(pad.R2 > 0 ? 1 : 0, ControllerButton::R2);
            MarkIfPressed(pad.RightStickBut, ControllerButton::R3);
            MarkIfPressed(pad.Menu, ControllerButton::Menu);
            MarkIfPressed(pad.View, ControllerButton::View);
        }
    }

    void MarkIfPressed(uint reading, ControllerButton button) {
        if (reading == 0) return;

        isDown[button] = true;
        lastUsedInputSource = InputSource::Controller;
    }

    bool TryGetDirection(ControllerButton button, PadDirection &out direction) {
        for (int i = 0; i < PadDirectionCount; i++) {
            PadDirection candidate = PadDirection(i);

            if (button == BindingFor(candidate)) {
                direction = candidate;
                return true;
            }
        }
        return false;
    }

    ControllerButton BindingFor(PadDirection direction) {
        if (direction == PadDirection::Up) return ControllerBindingUp;
        if (direction == PadDirection::Left) return ControllerBindingLeft;
        if (direction == PadDirection::Right) return ControllerBindingRight;
        return ControllerBindingDown;
    }
}
