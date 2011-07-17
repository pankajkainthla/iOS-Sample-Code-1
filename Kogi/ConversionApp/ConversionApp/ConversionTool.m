//
//  ConversionTool.m
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "ConversionTool.h"


@implementation ConversionTool

+ (CGFloat) convertDistance:(CGFloat)inputValue from:(int)fromUnits to:(int)toUnits {

	CGFloat baseValue = 0;
	CGFloat result = 0;
	
	switch (fromUnits) {
		case kMeters:
			baseValue = inputValue;
			break;
		case kNautic:
			baseValue = inputValue * 1852.0;
			break;
		case kYards:
			baseValue = inputValue * 0.9144;
			break;
	}
	
	switch (toUnits) {
		case kMeters:
			result = baseValue;
			break;
		case kNautic:
			result = baseValue * 0.000539956803;
			break;
		case kYards:
			result = baseValue * 1.0936133;
			break;
	}
	
	return result;
}

+ (CGFloat) convertTemperature:(CGFloat)inputValue from:(int)fromUnits to:(int)toUnits {

	CGFloat baseValue = 0;
	CGFloat result = 0;

	switch (fromUnits) {
		case kCelsius:
			baseValue = inputValue;
			break;
		case kFahrenheit:
			baseValue = (inputValue - 32.0) / 1.8;
			break;
		case kKelvin:
			baseValue = inputValue - 273.0;
	}
	
	switch (toUnits) {
		case kCelsius:
			result = baseValue;
			break;
		case kFahrenheit:
			result = (baseValue * 1.8) + 32;
			break;
		case kKelvin:
			result = baseValue + 273.0;
			break;
	}
	
	return result;
}

@end
