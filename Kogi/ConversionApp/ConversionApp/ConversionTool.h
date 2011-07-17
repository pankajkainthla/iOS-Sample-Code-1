//
//  ConversionTool.h
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	kCelsius = 0,
	kFahrenheit,
	kKelvin,
	
	kMeters,
	kNautic,
	kYards

};

@interface ConversionTool : NSObject {
    
}
+ (CGFloat) convertDistance:(CGFloat)inputValue from:(int)fromUnits to:(int)toUnits;
+ (CGFloat) convertTemperature:(CGFloat)inputValue from:(int)fromUnits to:(int)toUnits;
@end
