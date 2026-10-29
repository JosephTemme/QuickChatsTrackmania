// QuickChatMessages
// Looks up the configured message for a group and slot, and shortens long ones.

namespace QuickChatMessages {
    string GroupName(PadDirection group) {
        if (group == PadDirection::Up) return "Wishes";
        if (group == PadDirection::Left) return "Commentary";
        if (group == PadDirection::Right) return "Commendations";
        return "Consolations";
    }

    string TextFor(PadDirection group, PadDirection slot) {
        return ShortenToMaxLength(RawTextFor(group, slot));
    }

    string ShortenToMaxLength(const string &in text) {
        if (int(text.Length) <= MaxMessageLength) return text;
        return text.SubStr(0, MaxMessageLength) + " (...)";
    }

    string RawTextFor(PadDirection group, PadDirection slot) {
        if (group == PadDirection::Up) return WishesTextFor(slot);
        if (group == PadDirection::Left) return CommentaryTextFor(slot);
        if (group == PadDirection::Right) return CommendationsTextFor(slot);
        return ConsolationsTextFor(slot);
    }

    string WishesTextFor(PadDirection slot) {
        if (slot == PadDirection::Up) return WishesUpMessage;
        if (slot == PadDirection::Left) return WishesLeftMessage;
        if (slot == PadDirection::Right) return WishesRightMessage;
        return WishesDownMessage;
    }

    string CommentaryTextFor(PadDirection slot) {
        if (slot == PadDirection::Up) return CommentaryUpMessage;
        if (slot == PadDirection::Left) return CommentaryLeftMessage;
        if (slot == PadDirection::Right) return CommentaryRightMessage;
        return CommentaryDownMessage;
    }

    string CommendationsTextFor(PadDirection slot) {
        if (slot == PadDirection::Up) return CommendationsUpMessage;
        if (slot == PadDirection::Left) return CommendationsLeftMessage;
        if (slot == PadDirection::Right) return CommendationsRightMessage;
        return CommendationsDownMessage;
    }

    string ConsolationsTextFor(PadDirection slot) {
        if (slot == PadDirection::Up) return ConsolationsUpMessage;
        if (slot == PadDirection::Left) return ConsolationsLeftMessage;
        if (slot == PadDirection::Right) return ConsolationsRightMessage;
        return ConsolationsDownMessage;
    }
}
