// ===== QuickChatCore.as =====

// Truncation
string Trunc(const string &in s) {
    if (Setting_CharLimit <= 0 || int(s.Length) <= Setting_CharLimit) return s;
    return s.SubStr(0, Setting_CharLimit) + " (...)";
}

// Messages
string GetMsg(int group, int slot) {
    int i=(group-1)*4 + slot;
    if (i==0) return Setting_QuickChat1Message;
    if (i==1) return Setting_QuickChat2Message;
    if (i==2) return Setting_QuickChat3Message;
    if (i==3) return Setting_QuickChat4Message;
    if (i==4) return Setting_QuickChat5Message;
    if (i==5) return Setting_QuickChat6Message;
    if (i==6) return Setting_QuickChat7Message;
    if (i==7) return Setting_QuickChat8Message;
    if (i==8) return Setting_QuickChat9Message;
    if (i==9) return Setting_QuickChat10Message;
    if (i==10) return Setting_QuickChat11Message;
    if (i==11) return Setting_QuickChat12Message;
    if (i==12) return Setting_QuickChat13Message;
    if (i==13) return Setting_QuickChat14Message;
    if (i==14) return Setting_QuickChat15Message;
    if (i==15) return Setting_QuickChat16Message;
    return "";
}

// Spam & State
class SpamWindow {
    array<float> sends;
    bool canSend() {
        float now = float(Time::Now);
        for (int i = int(sends.Length) - 1; i >= 0; i--) {
            if (now - sends[i] > float(kSpamWindowMs)) sends.RemoveAt(i);
        }
        return int(sends.Length) < kSpamMax;
    }
    void noteSend() { sends.InsertLast(float(Time::Now)); }
}

class RLState {
    SpamWindow spam;
    bool waiting = false;
    int group = -1;
    float openedAt = 0;
    float lastSentAt = 0;
    void reset() { waiting = false; group = -1; openedAt = 0; }
    bool timedOut() const { return waiting && (float(Time::Now) - openedAt) > float(kSelectorTimeoutMs); }
    bool debounceOk() const { return lastSentAt == 0 || (float(Time::Now) - lastSentAt) > float(kDebounceMs); }
    void noteSend() { lastSentAt = float(Time::Now); spam.noteSend(); reset(); }
}
RLState g_state;

// Chat send
void SendChat(const string &in text) {
#if TMNEXT
    if (!Permissions::InGameChat()) return;
#endif
    string toSend = Trunc(text);
    print("\t" + toSend);
    auto pg = GetApp().CurrentPlayground;
    if (pg is null) { warn("No playground"); return; }
    if (toSend.Length > 2000) pg.Interface.ChatEntry = toSend.SubStr(0, 2000) + " (...)";
    else pg.Interface.ChatEntry = toSend;
}

// Clear UI + state
void ClearQueues() {
    for (int i = int(g_toasts.Length) - 1; i >= 0; i--) g_toasts.RemoveAt(i);
    for (int i = int(g_log.Length) - 1; i >= 0; i--) g_log.RemoveAt(i);
    g_state.reset();
    while (g_state.spam.sends.Length > 0) g_state.spam.sends.RemoveAt(g_state.spam.sends.Length - 1);
    g_state.lastSentAt = 0;
}

// Handle two-press quick-chat selector flow
void HandleSelector(int selectorIndex) {
    if (selectorIndex <= 0 || !Setting_Power || g_blockInput) return;
    if (!g_state.waiting) {
        if (selectorIndex >= 1 && selectorIndex <= 4) { g_state.waiting = true; g_state.group = selectorIndex; g_state.openedAt = float(Time::Now); }
        return;
    } else {
        if (!g_state.debounceOk()) return;
        int slot = SlotForSelector(selectorIndex);
        string msg = GetMsg(g_state.group, slot);
        if (!g_state.spam.canSend()) {
            if (Setting_LogSpamShow) AddLog("Muted briefly for spam control.", Setting_CooldownColor);
            g_state.reset(); return;
        }
        if (msg.Length > 0) {
            string clipped = Trunc(msg);
            SendChat(clipped);
            AddToastForSelector(clipped, selectorIndex);
            if (Setting_LogSentShow) AddLog(clipped, Setting_UseRectHint ? Setting_RectColor : Setting_HintColor);
            g_state.noteSend();
        } else g_state.reset();
    }
}
