// ===== QuickChatSettings.as =====

// Power
[Setting name="Toggle On/Off" category="Quick Chats"]
bool Setting_Power = true;

// Messages (Selector groups; 1=Up, 2=Left, 3=Right, 4=Down)
[Setting name="(Selector 1) First"  category="Messages"] string Setting_QuickChat1Message  = "Nice time!";
[Setting name="(Selector 1) Second" category="Messages"] string Setting_QuickChat2Message  = "gg";
[Setting name="(Selector 1) Third"  category="Messages"] string Setting_QuickChat3Message  = "PB!";
[Setting name="(Selector 1) Fourth" category="Messages"] string Setting_QuickChat4Message  = "This is Trackmania!";

[Setting name="(Selector 2) First"  category="Messages"] string Setting_QuickChat5Message  = "Watch this!";
[Setting name="(Selector 2) Second" category="Messages"] string Setting_QuickChat6Message  = "Need boost!";
[Setting name="(Selector 2) Third"  category="Messages"] string Setting_QuickChat7Message  = "Risk it!";
[Setting name="(Selector 2) Fourth" category="Messages"] string Setting_QuickChat8Message  = "Be careful!";

[Setting name="(Selector 3) First"  category="Messages"] string Setting_QuickChat9Message  = "Wow!";
[Setting name="(Selector 3) Second" category="Messages"] string Setting_QuickChat10Message = "Oops!";
[Setting name="(Selector 3) Third"  category="Messages"] string Setting_QuickChat11Message = "Close one!";
[Setting name="(Selector 3) Fourth" category="Messages"] string Setting_QuickChat12Message = "What a save!";

[Setting name="(Selector 4) First"  category="Messages"] string Setting_QuickChat13Message = "Tata for now";
[Setting name="(Selector 4) Second" category="Messages"] string Setting_QuickChat14Message = "Well played.";
[Setting name="(Selector 4) Third"  category="Messages"] string Setting_QuickChat15Message = "Go for it!";
[Setting name="(Selector 4) Fourth" category="Messages"] string Setting_QuickChat16Message = "No problem.";

// Bindings (UI order: Up, Left, Right, Down)
// Keyboard (defaults: I, J, L, K)
[Setting name="Selector 1 (Keyboard)" category="Bindings (Keyboard)"] VirtualKey Setting_QuickChat1Binding = VirtualKey::I;
[Setting name="Selector 2 (Keyboard)" category="Bindings (Keyboard)"] VirtualKey Setting_QuickChat2Binding = VirtualKey::J;
[Setting name="Selector 3 (Keyboard)" category="Bindings (Keyboard)"] VirtualKey Setting_QuickChat3Binding = VirtualKey::L;
[Setting name="Selector 4 (Keyboard)" category="Bindings (Keyboard)"] VirtualKey Setting_QuickChat4Binding = VirtualKey::K;

// Controller enum + defaults
enum Button { Left=0, Right, Up, Down, A,B,X,Y, L1,L2,L3, R1,R2,R3, Menu,View }
[Setting name="Selector 1 (Controller)" category="Bindings (Controller)"] Button Setting_QuickChat5Binding = Button::Up;
[Setting name="Selector 2 (Controller)" category="Bindings (Controller)"] Button Setting_QuickChat6Binding = Button::Left;
[Setting name="Selector 3 (Controller)" category="Bindings (Controller)"] Button Setting_QuickChat7Binding = Button::Right;
[Setting name="Selector 4 (Controller)" category="Bindings (Controller)"] Button Setting_QuickChat8Binding = Button::Down;

// Theme toggle
[Setting name="Use Theme 1 (RL-Style)" category="Theme"] bool Setting_UseRectHint = true;

// Theme — 1) Rectangle
[Setting name="Rect Color (RGBA)" category="Theme: 1) Rectangle" color] vec4 Setting_RectColor = vec4(0.10f, 0.78f, 0.48f, 150.0f/255.0f);
[Setting name="Rect Scale" category="Theme: 1) Rectangle"] float Setting_RectScale = 1.0f;
[Setting name="Rect Pos X (px)" category="Theme: 1) Rectangle"] int Setting_RectX = 40;
[Setting name="Rect Pos Y (px)" category="Theme: 1) Rectangle"] int Setting_RectY = 950;
[Setting name="Rect Width (px)" category="Theme: 1) Rectangle"] int Setting_RectW = 360;
[Setting name="Rect Line Spacing (px)" category="Theme: 1) Rectangle"] int Setting_RectLineSpacing = 6;
[Setting name="Rect Corner Rounding (px)" category="Theme: 1) Rectangle"] float Setting_RectCornerRounding = 10.0f;
[Setting name="Show Header (Selector n)" category="Theme: 1) Rectangle"] bool Setting_RectShowHeader = true;

// Theme — 2) Cross
[Setting name="Blob Color (RGBA)" category="Theme: 2) Cross" color] vec4 Setting_HintColor = vec4(0.10f, 0.78f, 0.48f, 230.0f/255.0f);
[Setting name="Font Size" category="Theme: 2) Cross"] int Setting_HintFontSize = 30;
[Setting name="Scale" category="Theme: 2) Cross"] float Setting_HintScale = 1.0f;
[Setting name="Center X (px)" category="Theme: 2) Cross"] int Setting_HintCenterX = 150;
[Setting name="Center Y (px)" category="Theme: 2) Cross"] int Setting_HintCenterY = 1100;
[Setting name="Blob Spacing X (px)" category="Theme: 2) Cross"] int Setting_HintSpacingX = 120;
[Setting name="Blob Spacing Y (px)" category="Theme: 2) Cross"] int Setting_HintSpacingY = 120;
[Setting name="Blob Width (px)" category="Theme: 2) Cross"] int Setting_BlobWidth = 220;
[Setting name="Corner Rounding (px)" category="Theme: 2) Cross"] float Setting_CornerRounding = 12.0f;

// Overlays
[Setting name="Show Toast Under Selection" category="Overlays"] bool Setting_ToastShow = true;
[Setting name="Show Sent Log (top-left)" category="Overlays"] bool Setting_LogSentShow = true;
[Setting name="Show Cooldown Log (top-left)" category="Overlays"] bool Setting_LogSpamShow = true;
[Setting name="Sent-Log Scale" category="Overlays"] float Setting_SentLogScale = 1.0f;
[Setting name="Sent-Log Offset X (px)" category="Overlays"] int Setting_SentLogOffsetX = 16;
[Setting name="Sent-Log Offset Y (px)" category="Overlays"] int Setting_SentLogOffsetY = 30;
[Setting name="Sent-Log Row Spacing (px)" category="Overlays"] int Setting_SentLogRowPx = 44;
[Setting name="Sent-Log Corner Rounding (px)" category="Overlays"] float Setting_SentLogCornerRounding = 8.0f;
[Setting name="Overlay Duration (ms)" category="Overlays"] int Setting_OverlayDurationMs = 1500;
[Setting name="Cooldown Color (RGBA)" category="Overlays" color] vec4 Setting_CooldownColor = vec4(1.0f, 0.9f, 0.2f, 1.0f);

// Hidden defaults / constants
const int Setting_CharLimit = 120;
const int kSelectorTimeoutMs = 1500;
const int kDebounceMs = 200;
const int kSpamMax = 3;
const int kSpamWindowMs = 4000;
