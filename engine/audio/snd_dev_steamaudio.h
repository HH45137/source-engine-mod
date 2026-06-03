#pragma once

#pragma comment(lib, "../../steamaudio/lib/windows-x64/phonon.lib")

#include "audio_pch.h"
#include <phonon.h>

class IAudioDevice;
IAudioDevice *Audio_CreateSteamAudioDevice(void);
