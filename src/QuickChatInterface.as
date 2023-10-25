const float BindingsAndMessagesBorderRadius = 10;
const float ShowBindingsDuration = 3000;
// Colors
const vec4 Pink = vec4(1, 0.2f, 0.6f, 1);
const vec4 TMGreen = vec4(0.2f, 1, 0.6f, 1);
const vec4 Blue = vec4(0, 0, 1, 1);

const int qcSizeX = 250;
const int qcSizeY = 100;
const int maxMessageLength = 23;
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

    void PowerOff()
    {
        showButtonBindingsEndTime = 0;
        showKeyBindingsEndTime = 0;
    }

    // Shows message that chat is disabled for a few more seconds.
    // Parameter: int msRemaining = milliseconds left till no longer considered spam.
    void ShowSpamHammerNotification()
    {
        //ToDo: Re-use.
        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        vec2 size = UI::GetWindowSize();
        vec2 pos = UI::GetWindowPos() / (screenSize - size);

        int centerX = int(pos.x) + (7*int(screenSize.x))/10;
        int centerY = int(pos.y) + (11*int(screenSize.y))/18;

        vec2 notificationPosition = vec2(centerX, centerY);

        if(oldestSpamContenderTime == 0)
            return;

        if(totalTime - oldestSpamContenderTime > SpamDetectionDuration)
        {
            // No longer spam.
            oldestSpamContenderTime = 0;
            return;
        }

        int convertedSecondsRemaining = int((SpamDetectionDuration - (totalTime - oldestSpamContenderTime))/1000) +1;
        string message = "Chat disabled for " + convertedSecondsRemaining;
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
        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        vec2 size = UI::GetWindowSize();
        vec2 pos = UI::GetWindowPos() / (screenSize - size);

        int centerX = int(pos.x) + (8*int(screenSize.x))/10;
        int centerY = int(pos.y) + (2*int(screenSize.y))/3;

        if(showKeyBindingsEndTime != 0 && totalTime < showKeyBindingsEndTime)
        {
            ShowBindingWithMessage(tostring(Setting_QuickChat1Binding), Setting_QuickChat1Message, centerX, centerY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat4Binding), Setting_QuickChat4Message, centerX - qcSizeX - 10, centerY + qcSizeY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat3Binding), Setting_QuickChat3Message, centerX, centerY + qcSizeY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat2Binding), Setting_QuickChat2Message, centerX + qcSizeX + 10, centerY + qcSizeY, qcSizeX, qcSizeY);
        }

        if(showButtonBindingsEndTime != 0 && totalTime < showButtonBindingsEndTime)
        {
            ShowBindingWithMessage(tostring(Setting_QuickChat5Binding), Setting_QuickChat5Message, centerX, centerY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat8Binding), Setting_QuickChat8Message, centerX - qcSizeX - 10, centerY + qcSizeY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat7Binding), Setting_QuickChat7Message, centerX, centerY + qcSizeY, qcSizeX, qcSizeY);
            ShowBindingWithMessage(tostring(Setting_QuickChat6Binding), Setting_QuickChat6Message, centerX + qcSizeX + 10, centerY + qcSizeY, qcSizeX, qcSizeY);
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

        nvg::FontSize(20);
        nvg::Text(posX+sizeX/2 - 9, posY+sizeY/4+10, binding);

        nvg::TextAlign(1);
        nvg::Text(posX+((sizeX - message.Length*8)/2) - 9, posY+2*sizeY/3, message);
    }
}