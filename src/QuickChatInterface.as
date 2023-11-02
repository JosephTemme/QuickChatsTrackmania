const float BindingsAndMessagesBorderRadius = 10;
const float ShowBindingsDuration = 3000;
// Colors
const vec4 Pink = vec4(1, 0.2f, 0.6f, 1);
const vec4 TMGreen = vec4(0.2f, 1, 0.6f, 1);
const vec4 TMGreenShadow = vec4(0.2f, 1, 0.6f, 0.5);
const vec4 Blue = vec4(0, 0, 1, 1);
const vec4 BlackShadow = vec4(0, 0, 0, 0.6);

const int maxMessageLength = 23;
class QuickChatUI
{
    float oldestSpamContenderTime = 0;
    float showKeyBindingsEndTime = 0;
    float showButtonBindingsEndTime = 0;
    vec2 screenSize;
    vec2 boxSize;
    vec2 boxPosition;
    vec2 notificationPosition;

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
        vec2 settingPos = vec2(1.0f, 1.0f);
        vec2 settingSize = vec2(350, 350);
        //ToDo: Re-use.
        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        vec2 size = UI::GetWindowSize();
//        vec2 pos = UI::GetWindowPos() / (screenSize - size);
        vec2 pos = settingPos * (screenSize - settingSize);

        int centerX = int(pos.x) + (7*int(screenSize.x))/10;
        int centerY = int(pos.y) + (6*int(screenSize.y))/9;

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
        nvg::FontSize(Setting_FontSize*3);

        nvg::Text(notificationPosition, message);
    }

    bool IsSpamHammerDown()
    {
        if(totalTime - oldestSpamContenderTime < 0)
            return true;
        return false;
    }

    void ShowBindings()
    {
        bool isShowingBindings = false;
        screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        boxSize = QCSize*5;
        boxPosition = vec2(screenSize.x * 0.75f * Setting_Position.x, screenSize.y * 0.5f * Setting_Position.y);

        vec2 textPos = vec2(boxPosition.x + boxSize.x * 0.1f, boxPosition.y + boxSize.y * 0.1f);

        if(showKeyBindingsEndTime != 0 && totalTime < showKeyBindingsEndTime)
        {
            isShowingBindings = true;
            ShowQuickChatsHeader(textPos.x, textPos.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat1Binding), Setting_QuickChat1Message,
                textPos.x, textPos.y + QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat4Binding), Setting_QuickChat4Message,
                textPos.x, textPos.y + 2*QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat3Binding), Setting_QuickChat3Message,
                textPos.x, textPos.y + 3*QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat2Binding), Setting_QuickChat2Message,
                textPos.x, textPos.y + 4*QCSize.y, QCSize.x, QCSize.y);
        }

        if(showButtonBindingsEndTime != 0 && totalTime < showButtonBindingsEndTime)
        {
            isShowingBindings = true;
            ShowQuickChatsHeader(textPos.x, textPos.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat5Binding), Setting_QuickChat5Message,
                textPos.x, textPos.y + QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat8Binding), Setting_QuickChat8Message,
                textPos.x, textPos.y + 2*QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat6Binding), Setting_QuickChat6Message,
                textPos.x, textPos.y + 3*QCSize.y, QCSize.x, QCSize.y);
            ShowBindingWithMessage(tostring(Setting_QuickChat7Binding), Setting_QuickChat7Message,
                textPos.x, textPos.y + 4*QCSize.y, QCSize.x, QCSize.y);
        }

        if(isShowingBindings)
        {
            // Rectangle
            nvg::BeginPath();
            nvg::RoundedRect(boxPosition.x, boxPosition.y, boxSize.x, boxSize.y, BindingsAndMessagesBorderRadius);
            nvg::StrokeWidth(1);
            nvg::StrokeColor(Setting_QuickChatsFontColor);
//            nvg::StrokeColor(TMGreen);


            // Fill
            nvg::FillColor(BlackShadow);
            nvg::Fill();

            nvg::Stroke();
        }
    }

    void ShowQuickChatsHeader(float posX, float posY)
    {
        //Text
        nvg::TextAlign(1);
        nvg::FontFace(6);
        nvg::FillColor(Setting_QuickChatsFontColor);
        nvg::FontSize(Setting_FontSize + 4);
        nvg::Text(posX, posY, "Quick Chats");
        nvg::Stroke();
    }

    void ShowBindingWithMessage(const string &in binding, const string &in message, float posX, float posY, float sizeX, float sizeY)
    {
        //Text
        nvg::TextAlign(1);
        nvg::FontFace(2);
        nvg::FillColor(Setting_QuickChatsFontColor);
        nvg::FontSize(Setting_FontSize);
        nvg::Text(posX, posY, binding + "\t" + message);
        nvg::Stroke();
    }
}