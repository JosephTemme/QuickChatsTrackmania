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
        if(key == Setting_QuickChat1Binding
            || key == Setting_QuickChat2Binding
            || key == Setting_QuickChat3Binding
            || key == Setting_QuickChat4Binding)
        {
            qc.inputQueueTimes.enqueue(totalTime);
            qc.inputQueueVirtualKeys.enqueue(key);
        }

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

    auto pressedButtons = UpdateControllerButtonStatus();
    // Add pressed buttons to the queue
    // Check if any pressed buttons are bound in settings and add them to the queue.
    for(int index = 0; index < pressedButtons.Length; index++)
    {
        if(pressedButtons[index] == true)
        {
            Button button = Button(index);
            if(button == Setting_QuickChat5Binding
                || button == Setting_QuickChat6Binding
                || button == Setting_QuickChat7Binding
                || button == Setting_QuickChat8Binding)
            {
                qc.inputQueueTimes.enqueue(totalTime);
                qc.inputQueueButtons.enqueue(button);
            }
        }
    }

    // Process queue
    qc.ProcessQueue(false);
}

void Render()
{
    qc.qci.RenderInterface();
}