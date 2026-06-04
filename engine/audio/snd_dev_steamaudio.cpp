#include "snd_dev_steamaudio.h"

// memdbgon must be the last include file in a .cpp file!!!
#include "phonon.h"
#include "tier0/memdbgon.h"

#ifndef DEDICATED

extern bool snd_firsttime;

class CAudioDeviceSteamAudio : public CAudioDeviceBase {
public:
  bool IsActive(void);
  bool Init(void);
  void Shutdown(void);
  void PaintEnd(void);
  int GetOutputPosition(void);
  void ChannelReset(int entnum, int channelIndex, float distanceMod);
  void Pause(void);
  void UnPause(void);
  float MixDryVolume(void);
  bool Should3DMix(void);
  void StopAllSounds(void);

  int PaintBegin(float mixAheadTime, int soundtime, int paintedtime);
  void ClearBuffer(void);
  void UpdateListener(const Vector &position, const Vector &forward,
                      const Vector &right, const Vector &up);
  void MixBegin(int sampleCount);
  void MixUpsample(int sampleCount, int filtertype);
  void Mix8Mono(channel_t *pChannel, char *pData, int outputOffset,
                int inputOffset, fixedint rateScaleFix, int outCount,
                int timecompress);
  void Mix8Stereo(channel_t *pChannel, char *pData, int outputOffset,
                  int inputOffset, fixedint rateScaleFix, int outCount,
                  int timecompress);
  void Mix16Mono(channel_t *pChannel, short *pData, int outputOffset,
                 int inputOffset, fixedint rateScaleFix, int outCount,
                 int timecompress);
  void Mix16Stereo(channel_t *pChannel, short *pData, int outputOffset,
                   int inputOffset, fixedint rateScaleFix, int outCount,
                   int timecompress);

  void TransferSamples(int end);
  void SpatializeChannel(int volume[CCHANVOLUMES / 2], int master_vol,
                         const Vector &sourceDir, float gain, float mono);
  void ApplyDSPEffects(int idsp, portable_samplepair_t *pbuffront,
                       portable_samplepair_t *pbufrear,
                       portable_samplepair_t *pbufcenter, int samplecount);

  const char *DeviceName(void) { return "SteamAudio"; }
  int DeviceChannels(void) { return 2; }
  int DeviceSampleBits(void) { return 16; }
  int DeviceSampleBytes(void) { return 2; }
  int DeviceDmaSpeed(void) { return SOUND_DMA_SPEED; }
  int DeviceSampleCount(void) { return m_deviceSampleCount; }

private:
  bool InitSteamAudioSettings();
  bool InitHRTF();

  IPLContextSettings m_steamAudioContextSettings{};
  IPLContext m_steamAudioContext = nullptr;
  IPLAudioSettings m_steamAudioSettings{};
  IPLHRTF m_steamAudioHrtf{};

  int m_deviceSampleCount;
};

Color errColor(200, 20, 20, 255);
Color logColor(100, 200, 100, 255);

IAudioDevice *Audio_CreateSteamAudioDevice(void) {
  CAudioDeviceSteamAudio *wave = NULL;
  if (!wave) {
    wave = new CAudioDeviceSteamAudio;
  }

  if (wave->Init()) {
    return wave;
  }

  delete wave;
  wave = nullptr;

  return nullptr;
}

#endif

bool CAudioDeviceSteamAudio::IsActive(void) { return true; }

bool CAudioDeviceSteamAudio::Init(void) {
  // this is the version of the Steam Audio API that your program has been
  // compiled against
  m_steamAudioContextSettings.version = STEAMAUDIO_VERSION;

  IPLerror errorCode =
      iplContextCreate(&m_steamAudioContextSettings, &m_steamAudioContext);
  if (errorCode) {
    ConColorMsg(errColor, "No Steam Audio device initialized\n");
    return false;
  }

  if (!InitSteamAudioSettings()) {
    return false;
  }

  if (!InitHRTF()) {
    return false;
  }

  ConColorMsg(logColor, "Steam Audio device initialized success\n");

  return true;
}

void CAudioDeviceSteamAudio::CAudioDeviceSteamAudio::Shutdown(void) {}

void CAudioDeviceSteamAudio::PaintEnd(void) {}
int CAudioDeviceSteamAudio::GetOutputPosition(void) { return 0; }
void CAudioDeviceSteamAudio::ChannelReset(int entnum, int channelIndex,
                                          float distanceMod) {}
void CAudioDeviceSteamAudio::Pause(void) {}
void CAudioDeviceSteamAudio::UnPause(void) {}
float CAudioDeviceSteamAudio::MixDryVolume(void) { return 0.0f; }
bool CAudioDeviceSteamAudio::Should3DMix(void) { return false; }
void CAudioDeviceSteamAudio::StopAllSounds(void) {}

int CAudioDeviceSteamAudio::PaintBegin(float mixAheadTime, int soundtime,
                                       int paintedtime) {
  return 0;
}
void CAudioDeviceSteamAudio::ClearBuffer(void) {}
void CAudioDeviceSteamAudio::UpdateListener(const Vector &position,
                                            const Vector &forward,
                                            const Vector &right,
                                            const Vector &up) {}
void CAudioDeviceSteamAudio::MixBegin(int sampleCount) {}
void CAudioDeviceSteamAudio::MixUpsample(int sampleCount, int filtertype) {}
void CAudioDeviceSteamAudio::Mix8Mono(channel_t *pChannel, char *pData,
                                      int outputOffset, int inputOffset,
                                      fixedint rateScaleFix, int outCount,
                                      int timecompress) {}
void CAudioDeviceSteamAudio::Mix8Stereo(channel_t *pChannel, char *pData,
                                        int outputOffset, int inputOffset,
                                        fixedint rateScaleFix, int outCount,
                                        int timecompress) {}
void CAudioDeviceSteamAudio::Mix16Mono(channel_t *pChannel, short *pData,
                                       int outputOffset, int inputOffset,
                                       fixedint rateScaleFix, int outCount,
                                       int timecompress) {}
void CAudioDeviceSteamAudio::Mix16Stereo(channel_t *pChannel, short *pData,
                                         int outputOffset, int inputOffset,
                                         fixedint rateScaleFix, int outCount,
                                         int timecompress) {}

void CAudioDeviceSteamAudio::TransferSamples(int end) {}
void CAudioDeviceSteamAudio::SpatializeChannel(int volume[CCHANVOLUMES / 2],
                                               int master_vol,
                                               const Vector &sourceDir,
                                               float gain, float mono) {}
void CAudioDeviceSteamAudio::ApplyDSPEffects(int idsp,
                                             portable_samplepair_t *pbuffront,
                                             portable_samplepair_t *pbufrear,
                                             portable_samplepair_t *pbufcenter,
                                             int samplecount) {}

bool CAudioDeviceSteamAudio::InitSteamAudioSettings() {
  m_steamAudioSettings.samplingRate = DeviceDmaSpeed();
  m_steamAudioSettings.frameSize = 512;

  return true;
}

bool CAudioDeviceSteamAudio::InitHRTF() {
  IPLHRTFSettings hrtfSettings{};

  hrtfSettings.type = IPL_HRTFTYPE_DEFAULT;

  IPLerror errorCode = iplHRTFCreate(m_steamAudioContext, &m_steamAudioSettings,
                                     &hrtfSettings, &m_steamAudioHrtf);
  if (errorCode) {
    return false;
  }

  return true;
}
