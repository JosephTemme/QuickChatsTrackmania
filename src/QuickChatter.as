const int InputQueueSize = 2;
const int MisClickDelay = 300;
const int QuickChatListenDelay = 2000;
const int QuickChatsTillSpam = 3;
const int SpamDetectionDuration = 4000;

class QuickChatter
{
    float lastSentTime = 0;
    bool lastPressWasKey = false;
    QuickChatUI qci = QuickChatUI();

    Queue inputQueueTimes = Queue(InputQueueSize);
    Queue inputQueueVirtualKeys = Queue(InputQueueSize);
    Queue inputQueueButtons = Queue(InputQueueSize);
    Queue sentChats = Queue(QuickChatsTillSpam);

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
//        auto pg = GetApp().CurrentPlayground;
//        if (pg is null) {
//            warn("Can't send message right now because there's no playground!");
//            return;
//        }
//
//        if (text.Length > 2000) {
//            pg.Interface.ChatEntry = text.SubStr(0, 2000) + " (...)";
//        } else {
//            pg.Interface.ChatEntry = text;
//        }

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
    }

    // Sends chats, if applicable.
    // parameters: bool isKeyPress: true if keyboard button press and not controller button press.
    void ProcessQueue(bool isKeyPress)
    {
        bool differentKeysWerePressed =
            lastPressWasKey != isKeyPress
            || (isKeyPress
                    && inputQueueVirtualKeys.peakFront() != -1 && inputQueueVirtualKeys.peakRear() != -1
                    && inputQueueVirtualKeys.peakFront() != inputQueueVirtualKeys.peakRear())
               || (!isKeyPress
                    && inputQueueButtons.peakFront() != -1 && inputQueueButtons.peakRear() != -1
                    && inputQueueButtons.peakFront() != inputQueueButtons.peakRear());

        // Dequeue from sentChats once out of spam detection range.
        if(totalTime - sentChats.peakFront() > SpamDetectionDuration){
            sentChats.dequeue();
        }

        // From the "beginning", iterate through circular queue to check if two key presses
        // are detected within the Mis-clickDelay duration.
        if(inputQueueTimes.peakFront() == inputQueueTimes.peakRear())
        {
            // Queue size is 1
        }
        else if(inputQueueTimes.peakRear() - inputQueueTimes.peakFront() > QuickChatListenDelay)
        {
            // Key/Button press was not quick enough.
            DequeueInputQueues();
        }
        else if(lastSentTime == 0 || inputQueueTimes.peakRear() - lastSentTime > MisClickDelay)
        {
            // Sending chat.
            if(sentChats.enqueue(inputQueueTimes.peakRear()) != -1)
            {
                if(differentKeysWerePressed)
                {
                    print("Different keys were pressed.");
                    DequeueInputQueues();
                }
                else
                {
                    lastSentTime = totalTime;
                    if(isKeyPress)
                        SendChatFromKey(inputQueueVirtualKeys.peakRear());
                    else
                        SendChatFromButton(inputQueueButtons.peakRear());
                }
            }
            else
            {
                qci.ActivateSpamHammer(sentChats.peakFront());
            }

            ClearQueues();
        }
        else
        {
            print("Mis-click/Sticky key/Supersonic spam protection.");
            ClearQueues();
        }

        lastPressWasKey = isKeyPress;
    }

    float MillisecondsRemainingOnSpamCooldown()
    {
        return inputQueueTimes.peakRear() - sentChats.peakFront();
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

    // Prints the contents of the queues.
    void DisplayQueues()
    {

        print("totalTime: \t" + totalTime);
        print("g_dt: \t" + g_dt);

        print("inputQueueVirtualKeys: ");
        inputQueueVirtualKeys.displayQueue();
        print("inputQueueButtons: ");
        inputQueueButtons.displayQueue();
        print("inputQueueTimes: ");
        inputQueueTimes.displayQueue();
    }


}