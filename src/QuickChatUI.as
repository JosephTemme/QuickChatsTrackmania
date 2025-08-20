// ===== QuickChatUI.as =====
// Toasts
class Toast { string text; float t0; int x; int y; }
array<Toast@> g_toasts;
void AddToast(const string &in txt, int x, int y) {
    Toast@ t = Toast(); t.text = txt; t.t0 = float(Time::Now); t.x=x; t.y=y; g_toasts.InsertLast(t);
}
void RenderToasts() {
    if (!Setting_ToastShow) return;
    vec4 baseCol = Setting_UseRectHint ? Setting_RectColor : Setting_HintColor;
    for (int i=int(g_toasts.Length)-1;i>=0;i--) {
        auto t=g_toasts[i]; float age=float(Time::Now)-t.t0;
        if (age>1200.0f) { g_toasts.RemoveAt(i); continue; }
        float a = baseCol.w * (1.0f - age/1200.0f);
        vec4 col = vec4(baseCol.x, baseCol.y, baseCol.z, a);
        UI::PushStyleColor(UI::Col::WindowBg, col);
        UI::PushStyleColor(UI::Col::Text, vec4(1,1,1,a));
        UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(10,6));
        UI::PushStyleVar(UI::StyleVar::WindowRounding, Setting_CornerRounding);
        UI::SetNextWindowPos(t.x, t.y, UI::Cond::Always);
        int flags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoSavedSettings | UI::WindowFlags::NoMove;
        if (UI::Begin("##toast_"+i, flags)) UI::Text(t.text); UI::End();
        UI::PopStyleVar(2);
        UI::PopStyleColor(2);
    }
}

// Sent-log
class LogItem { string text; float t0; vec4 col; }
array<LogItem@> g_log;
void AddLog(const string &in txt, const vec4 &in col) {
    LogItem@ it=LogItem(); it.text=txt; it.t0=float(Time::Now); it.col=col; g_log.InsertLast(it);
}
void RenderLog() {
    if (!Setting_LogSentShow && !Setting_LogSpamShow) return;
    int baseX=Setting_SentLogOffsetX, baseY=Setting_SentLogOffsetY;
    int rowH=int(Setting_SentLogRowPx*Setting_SentLogScale);
    for (int i=int(g_log.Length)-1;i>=0;i--) {
        auto t=g_log[i]; float age=float(Time::Now)-t.t0;
        if (age>float(Setting_OverlayDurationMs)) { g_log.RemoveAt(i); continue; }
        float a = t.col.w * (1.0f - age/float(Setting_OverlayDurationMs));
        vec4 col = vec4(t.col.x, t.col.y, t.col.z, a);
        UI::PushStyleColor(UI::Col::WindowBg, col);
        UI::PushStyleColor(UI::Col::Text, vec4(1,1,1,a));
        UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(10,6)*Setting_SentLogScale);
        UI::PushStyleVar(UI::StyleVar::WindowRounding, Setting_SentLogCornerRounding);
        UI::SetNextWindowPos(baseX, baseY + int((int(g_log.Length)-1-i)*rowH), UI::Cond::Always);
        int flags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoSavedSettings | UI::WindowFlags::NoMove;
        if (UI::Begin("##log_"+i, flags)) UI::Text(t.text); UI::End();
        UI::PopStyleVar(2);
        UI::PopStyleColor(2);
    }
}

// Hint Cross
void DrawOneBlob(const string &in text, int x, int y) {
    UI::PushStyleColor(UI::Col::WindowBg, Setting_HintColor);
    UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(10, 6) * Setting_HintScale);
    UI::PushStyleVar(UI::StyleVar::WindowRounding, Setting_CornerRounding);UI::SetNextWindowPos(x, y, UI::Cond::Always);
    int minW = Math::Max(48, Setting_BlobWidth);
    UI::SetNextWindowSize(int(float(minW) * Setting_HintScale), 0, UI::Cond::Always);
    int flags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoSavedSettings | UI::WindowFlags::NoMove;
    if (UI::Begin("##qc_blob_" + x + "_" + y, flags)) { UI::Text(text); } UI::End();UI::PopStyleVar(2);
    UI::PopStyleColor(1);
}
void DrawHintCross(int group) {
    int cx = Setting_HintCenterX;
    int cy = Setting_HintCenterY;
    int spX = int(float(Setting_HintSpacingX) * Setting_HintScale);
    int spY = int(float(Setting_HintSpacingY) * Setting_HintScale);
    string l=Trunc(GetMsg(group,0)), u=Trunc(GetMsg(group,1)), r=Trunc(GetMsg(group,2)), d=Trunc(GetMsg(group,3));
    DrawOneBlob(u, cx,       cy - spY);
    DrawOneBlob(l, cx - spX, cy);
    DrawOneBlob(r, cx + spX, cy);
    DrawOneBlob(d, cx,       cy + spY);
}

// Hint Rectangle
void DrawHintRect(int group) {
    vec4 col = Setting_RectColor;
    int x = Setting_RectX, y = Setting_RectY;
    int w = int(float(Setting_RectW) * Setting_RectScale);
    int linePad = int(float(Setting_RectLineSpacing) * Setting_RectScale);UI::PushStyleColor(UI::Col::WindowBg, col);
    UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(12,10) * Setting_RectScale);
    UI::PushStyleVar(UI::StyleVar::WindowRounding, Setting_RectCornerRounding);
    UI::SetNextWindowPos(x, y, UI::Cond::Always);
    UI::SetNextWindowSize(w, 0, UI::Cond::Always);
    int flags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoSavedSettings | UI::WindowFlags::NoMove;
    if (UI::Begin("##qc_rect", flags)) {
        if (Setting_RectShowHeader) UI::Text("Selector " + group);
        string keyUp   = (g_lastInput==0 ? BtnLabelKeyboard(1) : "Up");
        string keyLeft = (g_lastInput==0 ? BtnLabelKeyboard(2) : "Left");
        string keyRight= (g_lastInput==0 ? BtnLabelKeyboard(3) : "Right");
        string keyDown = (g_lastInput==0 ? BtnLabelKeyboard(4) : "Down");
        UI::Text(keyUp + ": "   + Trunc(GetMsg(group,1)));
        UI::Dummy(vec2(0,linePad));
        UI::Text(keyLeft + ": " + Trunc(GetMsg(group,0)));
        UI::Dummy(vec2(0,linePad));
        UI::Text(keyRight + ": "+ Trunc(GetMsg(group,2)));
        UI::Dummy(vec2(0,linePad));
        UI::Text(keyDown + ": " + Trunc(GetMsg(group,3)));
    }
    UI::End();
    UI::PopStyleVar(2);
    UI::PopStyleColor(1);}

// Toast placement (only for Cross)
void GetBlobPosForSelector(int selIdx, int &out x, int &out y) {
    int cx=Setting_HintCenterX, cy=Setting_HintCenterY;
    int spX=int(float(Setting_HintSpacingX)*Setting_HintScale);
    int spY=int(float(Setting_HintSpacingY)*Setting_HintScale);
    if (selIdx==2) { x=cx-spX; y=cy; }
    else if(selIdx==1) { x=cx; y=cy-spY; }
    else if(selIdx==4) { x=cx; y=cy+spY; }
    else if(selIdx==3) { x=cx+spX; y=cy; }
    else { x=cx; y=cy; }
}
void AddToastForSelector(const string &in msg, int selIdx) {
    if (Setting_UseRectHint) return;
    int bx,by; GetBlobPosForSelector(selIdx,bx,by);
    int tx=bx, ty=by + int(26*Setting_HintScale);
    if (Setting_ToastShow) AddToast(msg, tx, ty);
}
