const float BindingsAndMessagesBorderRadius = 10;
const float ShowBindingsDuration = 3000;
// Colors
const vec4 Pink = vec4(1, 0.2f, 0.6f, 1);
const vec4 TMGreen = vec4(0.2f, 1, 0.6f, 1);

const vec2 notificationPosition = vec2(1500, 950);
class QuickChatUI
{

    float oldestSpamContenderTime = 0;
    float showKeyBindingsEndTime = 0;
    float showButtonBindingsEndTime = 0;

    QuickChatUI() {}

    void RenderInterface()
    {
        ShowBindings();
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

    void ActivateKeyBindingDisplay()
    {
        showButtonBindingsEndTime = 0;
        showKeyBindingsEndTime = totalTime+ShowBindingsDuration;
    }
    
    void ActivateButtonBindingDisplay()
    {
        showKeyBindingsEndTime = 0;
        showButtonBindingsEndTime = totalTime+ShowBindingsDuration;
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

    void ShowBindings()
    {
        if(showKeyBindingsEndTime != 0 && totalTime < showKeyBindingsEndTime)
        {
            ShowBindingWithMessage(tostring(Setting_QuickChat1Binding), Setting_QuickChat1Message, 2100, 900, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat4Binding), Setting_QuickChat4Message, 1880, 1010, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat3Binding), Setting_QuickChat3Message, 2100, 1010, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat2Binding), Setting_QuickChat2Message, 2320, 1010, 200, 100);
        }

        if(showButtonBindingsEndTime != 0 && totalTime < showButtonBindingsEndTime)
        {
            ShowBindingWithMessage(tostring(Setting_QuickChat5Binding), Setting_QuickChat5Message, 2100, 900, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat8Binding), Setting_QuickChat8Message, 1880, 1010, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat7Binding), Setting_QuickChat7Message, 2100, 1010, 200, 100);
            ShowBindingWithMessage(tostring(Setting_QuickChat6Binding), Setting_QuickChat6Message, 2320, 1010, 200, 100);
        }
    }

    void ShowBindingWithMessage(const string &in binding, const string &in message, float posX, float posY, float sizeX, float sizeY)
    {
        // Rectangle
        nvg::BeginPath();
        nvg::RoundedRect(posX, posY, sizeX, sizeY, BindingsAndMessagesBorderRadius);
        nvg::StrokeWidth(5);

        nvg::StrokeColor(TMGreen);
        nvg::Stroke();

        nvg::TextAlign(1);
        nvg::FontSize(32);
        nvg::Text(posX+sizeX/2, posY+sizeY/4, binding);

        nvg::TextAlign(0);
        nvg::Text(posX+10, posY+sizeY/2, message);
    }
}