// Settings
// Behavior constants, then every user-facing setting in tab order.

const int MaxMessageLength = 120;

const uint64 SlotChoiceTimeoutMs = 1500;
const uint64 SendDebounceMs = 200;

const int SpamHammerMaxSends = 3;
const uint64 SpamHammerWindowMs = 4000;

[Setting name="Toggle On/Off" category="RL Quick Chats"]
bool IsPluginEnabled = true;

[Setting name="Wishes: Up" category="Messages" beforerender="RenderWishesHeader"] string WishesUpMessage = "Good luck!";
[Setting name="Wishes: Left" category="Messages"] string WishesLeftMessage = "gg";
[Setting name="Wishes: Right" category="Messages"] string WishesRightMessage = "Tata for now";
[Setting name="Wishes: Down" category="Messages"] string WishesDownMessage = "Have fun!";

[Setting name="Commentary: Up" category="Messages" beforerender="RenderCommentaryHeader"] string CommentaryUpMessage = "I wanna go fast!";
[Setting name="Commentary: Left" category="Messages"] string CommentaryLeftMessage = "Need boost!";
[Setting name="Commentary: Right" category="Messages"] string CommentaryRightMessage = "Slingshot: engaged.";
[Setting name="Commentary: Down" category="Messages"] string CommentaryDownMessage = "This is Trackmania!";

[Setting name="Commendations: Up" category="Messages" beforerender="RenderCommendationsHeader"] string CommendationsUpMessage = "Well played!";
[Setting name="Commendations: Left" category="Messages"] string CommendationsLeftMessage = "Nice time!";
[Setting name="Commendations: Right" category="Messages"] string CommendationsRightMessage = "PB!";
[Setting name="Commendations: Down" category="Messages"] string CommendationsDownMessage = "Impressive!";

[Setting name="Consolations: Up" category="Messages" beforerender="RenderConsolationsHeader"] string ConsolationsUpMessage = "If you ain't first you're last.";
[Setting name="Consolations: Left" category="Messages"] string ConsolationsLeftMessage = "Shake 'n bake";
[Setting name="Consolations: Right" category="Messages"] string ConsolationsRightMessage = "Whew.";
[Setting name="Consolations: Down" category="Messages"] string ConsolationsDownMessage = "Nooooo!";

[Setting name="Wishes Key" category="Bindings (Keyboard)"] VirtualKey KeyboardBindingUp = VirtualKey::I;
[Setting name="Commentary Key" category="Bindings (Keyboard)"] VirtualKey KeyboardBindingLeft = VirtualKey::J;
[Setting name="Commendations Key" category="Bindings (Keyboard)"] VirtualKey KeyboardBindingRight = VirtualKey::L;
[Setting name="Consolations Key" category="Bindings (Keyboard)"] VirtualKey KeyboardBindingDown = VirtualKey::K;

[Setting name="Wishes Button" category="Bindings (Controller)"] ControllerButton ControllerBindingUp = ControllerButton::Up;
[Setting name="Commentary Button" category="Bindings (Controller)"] ControllerButton ControllerBindingLeft = ControllerButton::Left;
[Setting name="Commendations Button" category="Bindings (Controller)"] ControllerButton ControllerBindingRight = ControllerButton::Right;
[Setting name="Consolations Button" category="Bindings (Controller)"] ControllerButton ControllerBindingDown = ControllerButton::Down;

[Setting name="Rect Color (RGBA)" category="Appearance" color] vec4 QuickChatMenuColor = vec4(0.10f, 0.78f, 0.48f, 0.85f);
[Setting name="Rect Scale" category="Appearance"] float QuickChatMenuScale = 1.5f;
[Setting name="Rect Pos X (px)" category="Appearance"] int QuickChatMenuPositionX = 40;
[Setting name="Rect Pos Y (px)" category="Appearance"] int QuickChatMenuPositionY = 850;
[Setting name="Rect Line Spacing (px)" category="Appearance"] int QuickChatMenuLineSpacing = 8;
[Setting name="Rect Corner Rounding (px)" category="Appearance"] float QuickChatMenuCornerRounding = 10.0f;
[Setting name="Show Group Header" category="Appearance"] bool ShowQuickChatMenuHeader = true;

[Setting name="Show Sent Messages (top-left)" category="Appearance"] bool ShowSentEntries = true;
[Setting name="Show Chat Disabled Notices (top-left)" category="Appearance"] bool ShowSpamHammerEntries = true;
[Setting name="Chat Log Scale" category="Appearance"] float ChatLogScale = 1.3f;
[Setting name="Chat Log Offset X (px)" category="Appearance"] int ChatLogOffsetX = 16;
[Setting name="Chat Log Offset Y (px)" category="Appearance"] int ChatLogOffsetY = 30;
[Setting name="Chat Log Row Spacing (px)" category="Appearance"] int ChatLogRowSpacing = 44;
[Setting name="Chat Log Max Entries" category="Appearance"] int ChatLogMaxEntries = 5;
[Setting name="Chat Log Corner Rounding (px)" category="Appearance"] float ChatLogCornerRounding = 8.0f;
[Setting name="Overlay Duration (ms)" category="Appearance"] int ChatLogEntryDurationMs = 3000;
[Setting name="Chat Disabled Color (RGBA)" category="Appearance" color] vec4 SpamHammerEntryColor = vec4(1.0f, 0.9f, 0.2f, 1.0f);

void RenderWishesHeader() {
    UI::SeparatorText("Wishes (Up)");
}

void RenderCommentaryHeader() {
    UI::SeparatorText("Commentary (Left)");
}

void RenderCommendationsHeader() {
    UI::SeparatorText("Commendations (Right)");
}

void RenderConsolationsHeader() {
    UI::SeparatorText("Consolations (Down)");
}
