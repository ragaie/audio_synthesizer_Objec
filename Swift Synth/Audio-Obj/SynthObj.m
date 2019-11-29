

#import "SynthObj.h"

@implementation SynthObj
+(SynthObj *)shared{
    return [[SynthObj alloc]init];
}

AVAudioEngine * audioEngine;
float  timex = 0;
double  sampleRate;
float  deltaTime;
//Signal  signal;

- (float )volume{
    return audioEngine.mainMixerNode.outputVolume;
    
}
-(void)setVolume:(float)volume{
    [audioEngine.mainMixerNode setOutputVolume:volume];
}
AVAudioSourceNode * sourceNode;

//float (^Signal)( float);



typedef float (^Signal)( float);

Signal signals;

//let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
//
//       for frame in 0..<Int(frameCount) {
//           let sampleVal = self.signal(self.time)
//           self.time += self.deltaTime
//
//           for buffer in ablPointer {
//               let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
//               buf[frame] = sampleVal
//           }
//       }
//       return noErr


//bufferList = (AudioBufferList *) malloc (
//                                         sizeof (AudioBufferList) + sizeof (AudioBuffer) * (channelCount - 1)
//                                         );
//
//if (NULL == bufferList) {NSLog (@"*** malloc failure for allocating bufferList memory"); return;}
//
//// initialize the mNumberBuffers member
//bufferList->mNumberBuffers = channelCount;
//
//// initialize the mBuffers member to 0
//AudioBuffer emptyBuffer = {0};
//size_t arrayIndex;
//for (arrayIndex = 0; arrayIndex < channelCount; arrayIndex++) {
//    // set up the AudioBuffer structs in the buffer list
//    bufferList->mBuffers[arrayIndex] = emptyBuffer;
//    bufferList->mBuffers[arrayIndex].mNumberChannels  = 1;
//    // How should mData be initialized???
//    bufferList->mBuffers[arrayIndex].mData            = malloc(sizeof(AudioUnitSampleType));
//}
//



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


//
//-(void) inializeNode{
//    sourceNode = [[ AVAudioSourceNode alloc] initWithRenderBlock:^OSStatus(BOOL * _Nonnull isSilence, const AudioTimeStamp * _Nonnull timestamp, AVAudioFrameCount frameCount, AudioBufferList * _Nonnull outputData) {
//        for (int frame = 0; frame < frameCount ; frame++){
//            float sampleVal = signals(timex);
//            timex += deltaTime;
//
//                    for (int bufferr = 0; bufferr < frameCount ; bufferr++){
//                        Float32 *buffer = (Float32 *)outputData->mBuffers[bufferr].mData;
//                        buffer[frame] = sampleVal;
//                    }
//        }
//        return noErr;
//    }];
//}




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
    
    
    if (![audioEngine startAndReturnError:&error]) {
        NSLog(@"engine failed to start: %@", error);
    }
    return  self;
}
-(void) setWaveformTo:(Signal) signal {
    signals = signal;
}


@end
