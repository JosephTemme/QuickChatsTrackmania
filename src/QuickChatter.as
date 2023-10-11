//class QuickChatter
//{
//    Hash quickChatBindings(4);
//    array<pair<int, float>> inputQueue;
//    array<string> list;
//    array<vec2<int, float>> inputQueue;
//public:
//    QuickChatter()
//    {
//        print("constructed new QuickChatter");
//    }

    // Sends a message to the server.
	void SendChat(const string &in text)
	{
		auto pg = GetApp().CurrentPlayground;
		if (pg is null) {
			//TODO: Queue the message for later
			warn("Can't send message right now because there's no playground!");
			return;
		}

		if (text.Length > 2000) {
			pg.Interface.ChatEntry = text.SubStr(0, 2000) + " (...)";
		} else {
			pg.Interface.ChatEntry = text;
		}
	}

    void QuickChatterMain()
	{
		while (true) {
			print("yielding");
			yield();
		}
	}
//}