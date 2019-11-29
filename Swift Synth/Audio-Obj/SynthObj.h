
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "OscillatorObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface SynthObj : NSObject
@property (nonatomic) float  volume;

+(SynthObj*)shared;
-(void) setWaveformTo:(Signal) signal ;
- (BOOL)isPlaying;
@end

NS_ASSUME_NONNULL_END
