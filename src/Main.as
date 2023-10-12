float g_dt = 0;
float totalTime = 0;
float sixteenMinutes = 1000000;
QuickChatter qc;

enum Button {
    Left = 0, Right, Up, Down,
    A, B, X, Y, L1, L2, L3, R1, R2, R3,
    Menu, View,
}

void Main()
{
	print("This is Rocket League!");
}

void OnSettingsChanged() {}

void OnKeyPress(bool down, VirtualKey key)
{
    if (down)
    {
        // Add pressed key and time to the queues
        qc.inputQueueTimes.enqueue(totalTime);
        qc.inputQueueVirtualKeys.enqueue(key);

        // Process queue
        qc.ProcessQueue(true);
    }
}

// Called every frame. `dt` is the delta time (milliseconds since last frame).
void Update(float dt)
{
    g_dt = dt;
    totalTime += dt;

    if (totalTime > sixteenMinutes)
    {
        totalTime = 0;
    }

//    //Reset totalTime when chats are sent or after some time.
//
//    auto pressedButtons = UpdateControllerButtonStatus(dt);
//
//    // ToDo: 1. Add pressed buttons to the queue
////    for(int index = 0; index < pressedButtons.Length; index++)
////    {
////        inputQueue[inputQIndex]
////    }
//    // ToDo: 2. process queue
////    ProcessQueue();
//    // ToDo: 3. send chats if applicable.
//
//
//
//
//    for(int index = 0; index < pressedButtons.Length; index++)
//    {
//        if(pressedButtons[index] && Setting_QuickChat5Binding == index)
//        {
//            qc.SendChat(Setting_QuickChat5Message);
//        }
//
//        if(pressedButtons[index] && Setting_QuickChat6Binding == index)
//        {
//            qc.SendChat(Setting_QuickChat6Message);
//        }
//
//        if(pressedButtons[index] && Setting_QuickChat7Binding == index)
//        {
//            qc.SendChat(Setting_QuickChat7Message);
//        }
//
//        if(pressedButtons[index] && Setting_QuickChat8Binding == index)
//        {
//            qc.SendChat(Setting_QuickChat8Message);
//        }
//    }
}

void Render()
{
    RenderInterface();
}