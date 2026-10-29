// Overlays
// Everything drawn on screen: the chat log, the quick chat menu,
// and the shared window style and scaled font they use.

const float OverlayBaseFontSize = 13.0f;

UI::Font@ overlayFont = UI::LoadFont("DroidSans.ttf", OverlayBaseFontSize);

namespace ChatLogOverlay {
    void Render() {
        if (!ShowSentEntries && !ShowSpamHammerEntries) return;

        chatLog.RemoveExpired();

        for (int row = 0; row < chatLog.Count(); row++) {
            ChatLogEntry@ entry = chatLog.EntryFromNewest(row);
            float alpha = entry.color.w * entry.RemainingLifeFraction();

            UI::PushStyleColor(UI::Col::WindowBg, vec4(entry.color.x, entry.color.y, entry.color.z, alpha));
            UI::PushStyleColor(UI::Col::Text, vec4(1, 1, 1, alpha));
            UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(10, 6) * ChatLogScale);
            UI::PushStyleVar(UI::StyleVar::WindowRounding, ChatLogCornerRounding);
            UI::SetNextWindowPos(ChatLogOffsetX, ChatLogOffsetY + row * ChatLogRowSpacing, UI::Cond::Always);

            if (UI::Begin("##chat_log_row_" + row, OverlayWindow::NonInteractiveFlags())) {
                OverlayWindow::PushScaledFont(ChatLogScale);
                UI::Text(entry.text);
                UI::PopFont();
            }
            UI::End();

            UI::PopStyleVar(2);
            UI::PopStyleColor(2);
        }
    }
}

namespace QuickChatMenuOverlay {
    void Render(PadDirection group) {
        int lineSpacing = int(float(QuickChatMenuLineSpacing) * QuickChatMenuScale);
        int headerSpacing = int(10 * QuickChatMenuScale);

        UI::PushStyleColor(UI::Col::WindowBg, QuickChatMenuColor);
        UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(14, 12) * QuickChatMenuScale);
        UI::PushStyleVar(UI::StyleVar::WindowRounding, QuickChatMenuCornerRounding);
        UI::SetNextWindowPos(QuickChatMenuPositionX, QuickChatMenuPositionY, UI::Cond::Always);

        if (UI::Begin("##quick_chat_menu", OverlayWindow::NonInteractiveFlags())) {
            OverlayWindow::PushScaledFont(QuickChatMenuScale);

            if (ShowQuickChatMenuHeader) {
                UI::Text(QuickChatMessages::GroupName(group));
                UI::Dummy(vec2(0, headerSpacing));
            }

            for (int i = 0; i < PadDirectionCount; i++) {
                PadDirection slot = PadDirection(i);

                if (i > 0) UI::Dummy(vec2(0, lineSpacing));
                UI::Text(ControlLabelFor(slot) + ": " + QuickChatMessages::TextFor(group, slot));
            }

            UI::PopFont();
        }
        UI::End();

        UI::PopStyleVar(2);
        UI::PopStyleColor(1);
    }

    string ControlLabelFor(PadDirection slot) {
        if (lastUsedInputSource == InputSource::Keyboard) return KeyboardInput::LabelFor(slot);
        return ControllerInput::LabelFor(slot);
    }
}

namespace OverlayWindow {
    int NonInteractiveFlags() {
        return UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize |
               UI::WindowFlags::NoSavedSettings | UI::WindowFlags::NoMove;
    }

    void PushScaledFont(float scale) {
        UI::PushFont(overlayFont, OverlayBaseFontSize * scale);
    }
}
