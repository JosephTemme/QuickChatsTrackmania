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
}

//array<vec2<VirtualKey, string>> QuickChats;
void OnSettingsChanged()
{
//    print("Quick chat settings changed.");

}

void OnKeyPress(bool down, VirtualKey key)
{
    if (down)
    {
        int keyValue = int(key);

        if(key == Setting_QuickChat1Binding)
            SendChat(Setting_QuickChat1Message);

        if(key == Setting_QuickChat2Binding)
            SendChat(Setting_QuickChat2Message);

        if(key == Setting_QuickChat3Binding)
            SendChat(Setting_QuickChat3Message);

        if(key == Setting_QuickChat4Binding)
            SendChat(Setting_QuickChat4Message);
    }
}

// Called every frame. `dt` is the delta time (milliseconds since last frame).
void Update(float dt)
{
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
}
