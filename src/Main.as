float g_dt = 0;
float totalTime = 0;
//QuickChatter@ qC;
//array<vec2<int, float>> inputQueue;

enum Button {
    Left = 0, Right, Up, Down,
    A, B, X, Y, L1, L2, L3, R1, R2, R3,
    Menu, View,
}

void Main()
{
	print("This is Rocket League!");

//	qC.quickChatBindings.insertItem(int(Setting_QuickChat1Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat2Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat3Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat4Binding));

//	QuickChatterMain();
//	auto qCSettings = new QuickChatSettings();

	// setup
//	@qC = QuickChatter();
//	qC.Main();
}

//array<vec2<VirtualKey, string>> QuickChats;
void OnSettingsChanged()
{
    print("Quick chat settings changed.");

//    qC.quickChatBindings.clear();
//    qC.quickChatBindings = Hash(4);
//
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat1Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat2Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat3Binding));
//    qC.quickChatBindings.insertItem(int(Setting_QuickChat4Binding));
}

void OnKeyPress(bool down, VirtualKey key)
{
    if (down)
    {
        print("Key pressed = ");
        print(key);

        int keyValue = int(key);
        print("(int)key = ");
        print(keyValue);

        if(key == VirtualKey::Up)
            SendChat(Setting_QuickChat1Message);

        if(key == VirtualKey::Right)
            SendChat(Setting_QuickChat2Message);

        if(key == VirtualKey::Down)
            SendChat(Setting_QuickChat3Message);

        if(key == VirtualKey::Left)
            SendChat(Setting_QuickChat4Message);
    }
//Hash logic start
//            auto hashValue = quickChatBindings[keyValue];
//            print("Hash value is: {hashValue}");
//            if (hashValue > 0)
//            {
//                auto newElement = new vec2(keyValue, totalTime);
////              inputQueue.InsertLast(newElement);
//                inputQueue.push_back(newElement);
//            }
//        }
}

// Called every frame. `dt` is the delta time (milliseconds since last frame).
void Update(float dt)
{
    // We need to save this for the Quick chat delay.
    // Without this dt the timing might be slightly off.
    g_dt = dt;
    auto pressedButtons = UpdateControllerButtonStatus(dt);

    for(int index = 0; index < pressedButtons.Length; index++)
    {
        if(pressedButtons[index] && Setting_QuickChat5Binding == index)
        {
            SendChat(Setting_QuickChat5Message);
        }

        if(pressedButtons[index] && Setting_QuickChat6Binding == index)
        {
            SendChat(Setting_QuickChat6Message);
        }

        if(pressedButtons[index] && Setting_QuickChat7Binding == index)
        {
            SendChat(Setting_QuickChat7Message);
        }

        if(pressedButtons[index] && Setting_QuickChat8Binding == index)
        {
            SendChat(Setting_QuickChat8Message);
        }
    }


//    totalTime += g_dt;

    // ToDo: 1s = 1000

//    print("Updated g_dt.");

}
