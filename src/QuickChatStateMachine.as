// QuickChatStateMachine
// Tracks the two-press flow: open a group, then pick a message.
// Owns the slot timeout and send debounce, and asks SpamHammer before sending.

QuickChatStateMachine quickChatStateMachine;

class QuickChatStateMachine {
    bool isAwaitingSlot = false;
    PadDirection openGroup = PadDirection::Up;

    private uint64 groupOpenedAtMs = 0;
    private uint64 lastSendAtMs = 0;
    private SpamHammer spamHammer;

    void OnDirectionPressed(PadDirection direction) {
        if (!isAwaitingSlot) {
            OpenGroup(direction);
        } else if (!IsInSendDebounce()) {
            ChooseSlot(direction);
        }
    }

    private void OpenGroup(PadDirection group) {
        isAwaitingSlot = true;
        openGroup = group;
        groupOpenedAtMs = Time::Now;
    }

    private bool IsInSendDebounce() {
        return lastSendAtMs != 0 && Time::Now - lastSendAtMs <= SendDebounceMs;
    }

    private void ChooseSlot(PadDirection slot) {
        string messageText = QuickChatMessages::TextFor(openGroup, slot);

        if (spamHammer.IsHammerDown()) {
            if (ShowSpamHammerEntries) {
                chatLog.AddSpamHammerNotice(spamHammer.ChatDisabledMessage());
            }
            Close();
            return;
        }
        if (messageText.Length == 0) {
            Close();
            return;
        }

        GameChat::Send(messageText);
        if (ShowSentEntries) {
            chatLog.AddSentMessage(messageText);
        }
        lastSendAtMs = Time::Now;
        spamHammer.RecordSend();
        Close();
    }

    private void Close() {
        isAwaitingSlot = false;
    }

    void CloseIfTimedOut() {
        if (isAwaitingSlot && Time::Now - groupOpenedAtMs > SlotChoiceTimeoutMs) {
            Close();
        }
    }

    void ResetEverything() {
        Close();
        lastSendAtMs = 0;
        spamHammer.Clear();
    }
}
