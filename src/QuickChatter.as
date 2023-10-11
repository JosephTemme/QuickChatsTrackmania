
    // Sends a message to the server.
	void SendChat(const string &in text)
	{
#if TMNEXT
		if (!Permissions::InGameChat()) {
			return;
		}
#endif
		auto pg = GetApp().CurrentPlayground;
		if (pg is null) {
			warn("Can't send message right now because there's no playground!");
			return;
		}

		if (text.Length > 2000) {
			pg.Interface.ChatEntry = text.SubStr(0, 2000) + " (...)";
		} else {
			pg.Interface.ChatEntry = text;
		}
	}
