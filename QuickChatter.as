class QuickChatter
{
    Hash quickChatBindings(4);
    queue<pair<int, float>> inputQueue;
public:
    QuickChatter()
    {
        print("constructed new QuickChatter");
    }

    void OnKeyPress(bool down, VirtualKey key)
    {
        print("Key pressed");
        if (down)
        {
            int keyValue = (int)key;
            auto hashValue = quickChatBindings[keyValue];
            print("Hash value is: {hashValue}");
            if (hashValue > 0)
                inputQueue.insert({keyValue, totalTime);
        }
    }

    void Main()
	{
		while (true) {
			print("yielding");
			yield();
		}
	}
}