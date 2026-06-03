#include "snd_dev_steamaudio.h"

// check CRCs and model sizes
Color errColor(200, 20, 20, 255);
Color logColor(100, 200, 100, 255);

IAudioDevice *Audio_CreateSteamAudioDevice(void)
{
    IPLContextSettings contextSettings{};

    // this is the version of the Steam Audio API that your program has been compiled against
    contextSettings.version = STEAMAUDIO_VERSION;

    // this is a handle to a context object, which we will initialize next
    IPLContext context = nullptr;

    IPLerror errorCode = iplContextCreate(&contextSettings, &context);
    if (errorCode)
    {
        ConColorMsg(errColor, "No Steam Audio device initialized\n");
    }
    ConColorMsg(logColor, "Steam Audio device initialized success\n");

    return nullptr;
}
