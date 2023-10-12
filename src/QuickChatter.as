const int InputQueueSize = 2;
const int SpamDelay = 500;
const int QuickChatListenDelay = 2000;

class QuickChatter
{
    float lastSentTime = 0;

    Queue inputQueueTimes = Queue(InputQueueSize);
    Queue inputQueueVirtualKeys = Queue(InputQueueSize);
    Queue inputQueueButtons = Queue(InputQueueSize);
//    Queue numChatsWithinSpamDelay = Queue()

    QuickChatter() {}

    // Sends a message to the server.
    void SendChat(const string &in text)
    {
#if TMNEXT
    if (!Permissions::InGameChat()) {
        return;
    }
#endif

        print("\t" + text);
    //    auto pg = GetApp().CurrentPlayground;
    //    if (pg is null) {
    //        warn("Can't send message right now because there's no playground!");
    //        return;
    //    }
    //
    //    if (text.Length > 2000) {
    //        pg.Interface.ChatEntry = text.SubStr(0, 2000) + " (...)";
    //    } else {
    //        pg.Interface.ChatEntry = text;
    //    }

        ClearQueues();
    }

    void SendChatFromKey(int keyId)
    {
        VirtualKey key = VirtualKey(keyId);
        if(key == Setting_QuickChat1Binding)
            SendChat(Setting_QuickChat1Message);

        if(key == Setting_QuickChat2Binding)
            SendChat(Setting_QuickChat2Message);

        if(key == Setting_QuickChat3Binding)
            SendChat(Setting_QuickChat3Message);

        if(key == Setting_QuickChat4Binding)
            SendChat(Setting_QuickChat4Message);

        ClearQueues();
    }

    void SendChatFromButton(int controllerButtonId)
    {
        Button controllerButton = Button(controllerButtonId);
        if(Setting_QuickChat5Binding == controllerButton)
        {
            SendChat(Setting_QuickChat5Message);
        }

        if(Setting_QuickChat6Binding == controllerButton)
        {
            SendChat(Setting_QuickChat6Message);
        }

        if(Setting_QuickChat7Binding == controllerButton)
        {
            SendChat(Setting_QuickChat7Message);
        }

        if(Setting_QuickChat8Binding == controllerButton)
        {
            SendChat(Setting_QuickChat8Message);
        }

        ClearQueues();
    }

    // Sends chats, if applicable.
    void ProcessQueue(bool isKeyPress)
    {
        // From the "beginning", iterate through circular queue to check if two key presses
        // are detected within the SpamDelay duration.
        if(inputQueueTimes.peakFront() == inputQueueTimes.peakRear())
        {
            // Queue size is 1
        }
        else if(inputQueueTimes.peakRear() - inputQueueTimes.peakFront() > QuickChatListenDelay)
        {
            // Key/Button press was not quick enough.
            DequeueInputQueues();
        }
        else if(lastSentTime == 0 || inputQueueTimes.peakRear() - lastSentTime > SpamDelay)
        {
            // Sending chat.
            lastSentTime = totalTime;

            if(isKeyPress)
                SendChatFromKey(inputQueueVirtualKeys.peakRear());
            else
                SendChatFromButton(inputQueueButtons.peakRear());
        }
        else
        {
            print("Spam hammer down.");
//            DisplayQueues();
//            print("lastSentTime: " + lastSentTime);
            ClearQueues();
        }
    }

    int DequeueInputQueues()
    {
        inputQueueTimes.dequeue();
        inputQueueVirtualKeys.dequeue();
        inputQueueButtons.dequeue();
        return -1;
    }

    void ClearQueues()
    {
        while(inputQueueTimes.dequeue() != -1)
        {
        }

        while(inputQueueVirtualKeys.dequeue() != -1)
        {
        }

        while(inputQueueButtons.dequeue() != -1)
        {
        }
    }

    void DisplayQueues()
    {
//        inputQueueVirtualKeys.displayQueue();
//        inputQueueButtons.displayQueue();
        inputQueueTimes.displayQueue();
    }
}