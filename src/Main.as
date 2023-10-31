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

void OnSettingsChanged()
{
    if(!Setting_Power)
    {
        qc.qci.PowerOff();
    }
}

void OnNewServerAsync()
{
    while (GetApp().CurrentPlayground is null) {
        yield();
    }
}

void OnServerChanged(const string &in login)
{
    print("Server changed.");
    totalTime = 0;
    qc.ClearQueues();

    if (login != "") {
        return;
    }
    startnew(CoroutineFunc(OnNewServerAsync));
}

void OnKeyPress(bool down, VirtualKey key)
{
    bool buttonWasPressed = false;

    if(!Setting_Power)
    {
        return;
    }

    auto app = GetApp();
    if(app.InputPort.CurrentActionMap == "MenuInputsMap")
    {
        qc.ClearQueues();
        return;
    }

    if(!down)
    {
        return;
    }

    // Add pressed key and time to the queues
    if(key == Setting_QuickChat1Binding
        || key == Setting_QuickChat2Binding
        || key == Setting_QuickChat3Binding
        || key == Setting_QuickChat4Binding)
    {
        buttonWasPressed = true;
        qc.inputQueueTimes.enqueue(int(totalTime));
        qc.inputQueueVirtualKeys.enqueue(key);
    }

    // Process queue
    if(buttonWasPressed)
    {
        qc.ProcessQueue(true);
        qc.qci.ActivateKeyBindingDisplay();
    }
}

// Called every frame. `dt` is the delta time (milliseconds since last frame).
void Update(float dt)
{
    bool buttonWasPressed = false;

    if(!Setting_Power)
    {
        return;
    }

    g_dt = dt;
    totalTime += dt;

    // Prevent float overflow by resetting counters.
    if (totalTime > sixteenMinutes)
    {
        ResetTimersAndQueues();
    }

    auto app = GetApp();
    if(app.InputPort.CurrentActionMap == "MenuInputsMap")
    {
        qc.ClearQueues();
        return;
    }

    auto pressedButtons = UpdateControllerButtonStatus();
    // Add pressed buttons to the queue
    // Check if any pressed buttons are bound in settings and add them to the queue.
    for(int index = 0; index < int(pressedButtons.Length); index++)
    {
        if(pressedButtons[index] == true)
        {
            Button button = Button(index);
            if(button == Setting_QuickChat5Binding
                || button == Setting_QuickChat6Binding
                || button == Setting_QuickChat7Binding
                || button == Setting_QuickChat8Binding)
            {
                qc.inputQueueTimes.enqueue(int(totalTime));
                qc.inputQueueButtons.enqueue(button);
                buttonWasPressed = true;
            }
        }
    }

    // Process queue
    if(buttonWasPressed)
    {
        qc.ProcessQueue(false);
        qc.qci.ActivateButtonBindingDisplay();
    }
}

void ResetTimersAndQueues()
{
    totalTime = 0;
    g_dt = 0;
    qc.ClearQueues();
    qc.qci.ActivateSpamHammer(0);
    qc.lastSentTime = 0;
}

void Render()
{
    qc.qci.RenderInterface();
}