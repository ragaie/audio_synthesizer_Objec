

#import "SynthObj.h"

@implementation SynthObj


static SynthObj *_sharedMySingleton = nil;

+(SynthObj *)shared {
    @synchronized([SynthObj class]) {
        if (!_sharedMySingleton)
          _sharedMySingleton = [[SynthObj alloc]init];
        return _sharedMySingleton;
    }
    return nil;
}
AVAudioEngine * audioEngine;
float  timex = 0;
double  sampleRate;
float  deltaTime;
bool isplaying = false;
- (float )volume{
    return audioEngine.mainMixerNode.outputVolume;
    
}
- (BOOL)isPlaying{
    return isplaying;

}
-(void)setVolume:(float)volume{
    if (volume == 0 ){
        isplaying = false;
    }
    else{
        isplaying = true;

    }
        [audioEngine.mainMixerNode setOutputVolume:volume];

    }
AVAudioSourceNode * sourceNode;
typedef float (^Signal)( float);
Signal signals;
-(void) inializeNode{
    sourceNode = [[ AVAudioSourceNode alloc] initWithRenderBlock:^OSStatus(BOOL * _Nonnull isSilence, const AudioTimeStamp * _Nonnull timestamp, AVAudioFrameCount frameCount, AudioBufferList * _Nonnull outputData) {
        for (int frame = 0; frame < frameCount ; frame++){
            float sampleVal = signals(timex);
            timex += deltaTime;
            
            for (int bufferr = 0; bufferr < outputData->mNumberBuffers ; bufferr++){
                Float32 *buffer = (Float32 *)outputData->mBuffers[bufferr].mData;
                buffer[frame] = sampleVal;
            }
        }
        return noErr;
    }];
}
- (id)init {
    self = [super init];
    if (self) {
        if (signals == nil){
        return  [self initClass: [OscillatorObj sine]];
    
        }
        else{
            return  [self initClass: signals];
        }
    }
    return self;
}


- (SynthObj*)initClass:(Signal)signal{
    
    audioEngine = [[AVAudioEngine alloc] init];
    AVAudioMixerNode * mainMixer = audioEngine.mainMixerNode;
    AVAudioOutputNode * outputNode = audioEngine.outputNode;
    AVAudioFormat *format =  [outputNode inputFormatForBus:0];
    sampleRate = format.sampleRate;
    deltaTime =  1 / (float) sampleRate;
    
    signals = signal;
    
    AVAudioFormat * inputFormat = [[AVAudioFormat alloc] initWithCommonFormat:format.commonFormat sampleRate:sampleRate channels:1 interleaved:format.isInterleaved];
    [self inializeNode];
    [audioEngine attachNode:sourceNode];
    [audioEngine connect:sourceNode to:mainMixer format:inputFormat];
    [audioEngine connect:mainMixer to:outputNode format:nil];
    mainMixer.outputVolume = 0;
    NSError *error = nil;
    
   //isplaying = true;
    if (![audioEngine startAndReturnError:&error]) {
        NSLog(@"engine failed to start: %@", error);
    }
    return  self;
}
-(void) setWaveformTo:(Signal) signal {
    signals = signal;
}


@end
