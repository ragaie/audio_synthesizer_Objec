//
//  OscillatorObj.h
//  Swift Synth
//
//  Created by Ragaie Alfy on 11/28/19.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger, WaveformObj) {
    sine,
    triangle,
    sawtooth,
    square,
    whiteNoise
};
@interface OscillatorObj : NSObject

typedef float (^Signal)( float);

+(float)amplitude ;
+(void)setAmplitude:(float) val ;
+(float) frequency ;
+(void) setFrequency:(float) val ;

@property(nonatomic) WaveformObj waveType ;

+(Signal)sine;

+(Signal)triangle;


+(Signal)sawtooth;

+(Signal)square;
+(Signal)whiteNoise;
@end

NS_ASSUME_NONNULL_END
