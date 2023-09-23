float g_dt = 0;
float totalTime = 0;
QuickChatter@ qC;

void Main()
{
	print("This is Rocket League!");

	// setup
	@qC = QuickChatter();
	qC.Main();
}

void OnSettingsChanged()
{
    print("Quick chat settings changed.");

    qC.quickChatBindings.clear();
    qC.quickChatBindings = Hash(4);

    qC.quickChatBindings.insertItem(int(Setting_QuickChat1Binding));
    qC.quickChatBindings.insertItem(int(Setting_QuickChat2Binding));
    qC.quickChatBindings.insertItem(int(Setting_QuickChat3Binding));
    qC.quickChatBindings.insertItem(int(Setting_QuickChat4Binding));
}

void Update(float dt)
{
    // We need to save this for the Quick chat delay.
    // Without this dt the timing might be slightly off.
    g_dt = dt;
    totalTime += g_dt;
}
