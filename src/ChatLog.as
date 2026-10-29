// ChatLog
// The short-lived list of recent sent messages and spam-hammer notices.
// Capped at ChatLogMaxEntries; the oldest entry drops first.

ChatLog chatLog;

class ChatLogEntry {
    string text;
    uint64 createdAtMs;
    vec4 color;

    ChatLogEntry(const string &in text, const vec4 &in color) {
        this.text = text;
        this.createdAtMs = Time::Now;
        this.color = color;
    }

    float AgeMs() const {
        return float(Time::Now - createdAtMs);
    }

    float RemainingLifeFraction() const {
        return 1.0f - AgeMs() / float(ChatLogEntryDurationMs);
    }
}

class ChatLog {
    array<ChatLogEntry@> entries;

    void AddSentMessage(const string &in text) {
        AddEntry(ChatLogEntry(text, QuickChatMenuColor));
    }

    void AddSpamHammerNotice(const string &in text) {
        AddEntry(ChatLogEntry(text, SpamHammerEntryColor));
    }

    private void AddEntry(ChatLogEntry@ entry) {
        entries.InsertLast(entry);

        while (entries.Length > 0 && int(entries.Length) > ChatLogMaxEntries) {
            entries.RemoveAt(0);
        }
    }

    int Count() {
        return int(entries.Length);
    }

    ChatLogEntry@ EntryFromNewest(int rowFromNewest) {
        return entries[Count() - 1 - rowFromNewest];
    }

    void RemoveExpired() {
        for (int i = int(entries.Length) - 1; i >= 0; i--) {
            if (entries[i].AgeMs() > float(ChatLogEntryDurationMs)) {
                entries.RemoveAt(i);
            }
        }
    }

    void Clear() {
        entries = array<ChatLogEntry@>();
    }
}
