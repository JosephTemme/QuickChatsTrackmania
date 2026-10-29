// SpamHammer
// Limits how many messages can be sent in a short window.
// Also words the "Chat disabled for N seconds" notice.

SpamHammer spamHammer;

class SpamHammer {
    private array<uint64> sendTimesMs;

    bool IsHammerDown() {
        RemoveExpiredSends();
        return int(sendTimesMs.Length) >= SpamHammerMaxSends;
    }

    private void RemoveExpiredSends() {
        for (int i = int(sendTimesMs.Length) - 1; i >= 0; i--) {
            if (Time::Now - sendTimesMs[i] > SpamHammerWindowMs) {
                sendTimesMs.RemoveAt(i);
            }
        }
    }

    string ChatDisabledMessage() {
        int seconds = SecondsUntilChatReturns();
        string unit = " seconds";

        if (seconds == 1) unit = " second";
        return "Chat disabled for " + seconds + unit;
    }

    private int SecondsUntilChatReturns() {
        uint64 chatReturnsAtMs;
        uint64 remainingMs = 0;

        if (sendTimesMs.Length == 0) return 1;

        chatReturnsAtMs = sendTimesMs[0] + SpamHammerWindowMs;
        if (chatReturnsAtMs > Time::Now) remainingMs = chatReturnsAtMs - Time::Now;

        return Math::Max(1, int((remainingMs + 999) / 1000));
    }

    void RecordSend() {
        sendTimesMs.InsertLast(Time::Now);
    }

    void Clear() {
        sendTimesMs = array<uint64>();
    }
}
