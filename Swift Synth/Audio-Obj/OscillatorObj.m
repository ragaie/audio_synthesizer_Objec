//
//  OscillatorObj.m
//  Swift Synth
//
//  Created by Ragaie Alfy on 11/28/19.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import "OscillatorObj.h"

@implementation OscillatorObj

static float  amplitude  = 1;
static float  frequency  = 440;

+(float)amplitude {
    
    return amplitude;
    
};
+(void)setAmplitude:(float)val{
    amplitude = val;
}
+(float) frequency {
    return frequency;
};
+(void)setFrequency:(float)val{
    frequency = val;
}

+(Signal)sine{
    return  ^ ( float time) {
           return  [OscillatorObj amplitude] * (float)sin(2.0 * M_PI  * [OscillatorObj frequency] * time);
    };

}

+(Signal)triangle{
    return  ^ ( float time) {
            double period = 1.0 / (double)[OscillatorObj frequency];
              double currentTime = fmod((double)time, period);
              double value = currentTime / period;
              double result = 0.0;
              if (value < 0.25){
                  result = value * 4;
              }
              else if( value < 0.75){
                  result = 2.0 - (value * 4.0);
              }else{
                  result = value * 4 - 4.0;
              }
              return  [OscillatorObj amplitude] * (float)result;
    };
}


+(Signal)sawtooth{
    return  ^ ( float time) {
           float  period = 1.0 / [OscillatorObj frequency];
           double currentTime = fmod((double)time, (double)period);
           return (float)([OscillatorObj amplitude ] * (((float)currentTime / period) * 2 - 1.0));
    };
}

+(Signal)square{
    return  ^ ( float time) {
        double period = 1.0 / (double)[OscillatorObj frequency ];
           double currentTime = fmod((double)time, period);
           if ( (currentTime / period) < 0.5 ){
               return [OscillatorObj amplitude ];
           }else{
               return  (float)(-1.0 * [OscillatorObj amplitude ]);
           }
    };
}

// static let whiteNoise = { (time: Float) -> Float in
//     return Oscillator.amplitude * Float.random(in: -1...1)
// }
+(Signal)whiteNoise{
    return  ^ ( float time) {
       // ((float)rand() / RAND_MAX) * 5;
       //  random
            return [OscillatorObj amplitude ] * (((float)rand() / RAND_MAX)) * -1;;
    };
}
@end
