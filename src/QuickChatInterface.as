
class QuickChatUI
{
    vec2 notificationPosition = vec2(1500, 950);
    float oldestSpamContenderTime = 0;

    QuickChatUI() {}

    void RenderInterface()
    {
        // Rectangle
        nvg::BeginPath();
    //    nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Gearbox_BorderRadius);
        nvg::RoundedRect(2300, 1000, 100, 100, 1);
        nvg::StrokeWidth(5);

        nvg::StrokeColor(vec4(1, 0.2f, 0.6f, 1));
        nvg::FillColor(vec4(0.2f, 1, 0.6f, 1));

        nvg::Fill();

        ShowNotifications();
    }

    void ShowNotifications()
    {
        ShowSpamHammerNotification();
    }

    void ActivateSpamHammer(float queueFrontTime)
    {
        oldestSpamContenderTime = queueFrontTime;
    }

    // Shows message that chat is disabled for a few more seconds.
    // Parameter: int msRemaining = milliseconds left till no longer considered spam.
    void ShowSpamHammerNotification()
    {
        if(oldestSpamContenderTime == 0)
            return;

        if(totalTime - oldestSpamContenderTime > SpamDetectionDuration)
        {
            // No longer spam.
            oldestSpamContenderTime = 0;
            return;
        }

        int convertedSecondsRemaining = int((SpamDetectionDuration - (totalTime - oldestSpamContenderTime))/1000) +1;
        string message = "Spam hammer down for " + convertedSecondsRemaining;
        if(convertedSecondsRemaining == 1)
        {
            message += " second.";
        }
        else
        {
            message += " seconds.";
        }

        nvg::BeginPath();
        nvg::StrokeColor(vec4(1.0, 1.0, 1.0, 1.0));
        nvg::FillColor(vec4(1.0, 1.0, 1.0, 1.0));
        nvg::FontSize(52);

        nvg::Text(notificationPosition, message);
    }
}