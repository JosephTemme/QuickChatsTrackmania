// GameInterface
// The only place that talks to the game: menu and chat checks, and sending chat.

namespace GameContext {
    bool IsInMenu() {
#if TMNEXT
        auto app = GetApp();
        if (app is null || app.InputPort is null) return false;
        return app.InputPort.CurrentActionMap == "MenuInputsMap";
#endif
        return false;
    }

    bool IsChatAvailable() {
        auto app = GetApp();
        if (app is null) return false;
#if TMNEXT
        if (!Permissions::InGameChat()) return false;
#endif
        return app.CurrentPlayground !is null;
    }
}

namespace GameChat {
    void Send(const string &in text) {
        print("\t" + text);

        auto playground = GetApp().CurrentPlayground;
        if (playground is null) {
            warn("No playground");
            return;
        }
        playground.Interface.ChatEntry = text;
    }
}
