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

    bool SendChat(string _chat)
    {
        print(_chat);
        //ToDo: open chat window, fill with chat, press send

        return true;
    }

    void QuickChatterMain()
	{
		while (true) {
			print("yielding");
			yield();
		}
	}
//}