//
//  ConversionAppTests.m
//  ConversionAppTests
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "ConversionAppTests.h"
#import "ConversionTool.h"

#define kTempAccuracy 0.3
#define kDistAccuracy 0.001

@implementation ConversionAppTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{    
    [super tearDown];
}

- (void) testConvertDistance {
	
	CGFloat initialValue = 100;
	CGFloat expectedValue = 100;
	CGFloat result = 0;
	
	/*********** Test from M ***********/
	//100 meters = 100 meters
	result = [ConversionTool convertDistance:initialValue from:kMeters to:kMeters];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Meters to Meters Failed");

	//100 meters = 0.0539956803 nautical miles
	expectedValue = 0.0539956803;
	
	result = [ConversionTool convertDistance:initialValue from:kMeters to:kNautic];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Meters to Nautical Failed");

	//100 meters = 109.36133 yards
	expectedValue = 109.36133;
	
	result = [ConversionTool convertDistance:initialValue from:kMeters to:kYards];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Meters to Yards Failed");

	
	/*********** Test from Nautic Miles ***********/
	//100 nautical miles = 185 200 meters
	expectedValue = 185200;
	
	result = [ConversionTool convertDistance:initialValue from:kNautic to:kMeters];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Nautic to Meters Failed");
	
	//100 nautical miles = 100 nautical miles
	expectedValue = 100;
	
	result = [ConversionTool convertDistance:initialValue from:kNautic to:kNautic];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Nautic to Nautic Failed");
	
	//100 nautical miles = 202 537.183 yards
	expectedValue = 202537.183;
	
	result = [ConversionTool convertDistance:initialValue from:kNautic to:kYards];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Nautic to Yards Failed");
	
	
	/*********** Test from Yards ***********/
	//100 yards = 91.44 meters
	expectedValue = 91.44;
	
	result = [ConversionTool convertDistance:initialValue from:kYards to:kMeters];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Yards to Meters Failed");
	
	//100 yards = 0.0493736501 nautical miles
	expectedValue = 0.0493736501;
	
	result = [ConversionTool convertDistance:initialValue from:kYards to:kNautic];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Yards to Nautical Failed");

	//100 yards = 100 yards	
	expectedValue = 100;
	
	result = [ConversionTool convertDistance:initialValue from:kYards to:kYards];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"Yards to Yards Failed");

}

- (void) testConvertTemperature {

	CGFloat initialValue = 100;
	CGFloat expectedValue = 212;
	CGFloat result = 0;

	/*********** Test from C ***********/
	
	//100 degrees Celsius = 212 degrees Fahrenheit
	result = [ConversionTool convertTemperature:initialValue from:kCelsius to:kFahrenheit];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"C to F Failed");

	//100 degrees Celsius = 100 degrees Celsius
	expectedValue = 100;
	
	result = [ConversionTool convertTemperature:initialValue from:kCelsius to:kCelsius];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"C to C Failed");

	//100 degrees Celsius = 373.15 kelvin
	expectedValue = 373.15;
	
	result = [ConversionTool convertTemperature:initialValue from:kCelsius to:kKelvin];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"K to K Failed");

	
	/*********** Test from F ***********/
	//100 degrees Fahrenheit = 37.7777778 degrees Celsius
	initialValue = 100;
	expectedValue = 37.7777778;
	
	result = [ConversionTool convertTemperature:initialValue from:kFahrenheit to:kCelsius];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"F to C Failed");
	
	//100 degrees Fahrenheit = 100 degrees Fahrenheit
	expectedValue = 100;
	
	result = [ConversionTool convertTemperature:initialValue from:kFahrenheit to:kFahrenheit];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"F to F Failed");
	
	//100 degrees Fahrenheit = 310.927778 kelvin
	expectedValue = 310.927778;
	
	result = [ConversionTool convertTemperature:initialValue from:kFahrenheit to:kKelvin];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"F to K Failed");
	
	
	/*********** Test from K ***********/
	//100 kelvin = -173.15 degrees Celsius
	initialValue = 100;
	expectedValue = -173.15;
	
	result = [ConversionTool convertTemperature:initialValue from:kKelvin to:kCelsius];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"K to C Failed");

	//100 kelvin = -279.67 degrees Fahrenheit
	expectedValue = -279.67;
	
	result = [ConversionTool convertTemperature:initialValue from:kKelvin to:kFahrenheit];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"K to F Failed");
	
	//100 kelvin = 100 degrees Kelvin
	expectedValue = 100;
	
	result = [ConversionTool convertTemperature:initialValue from:kKelvin to:kKelvin];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"K to K Failed");
	
}

- (void) testLimitCasesDistance {
	
	CGFloat initialValue = -1000;
	CGFloat expectedValue = -0.539956803;
	CGFloat result = -10;
	
	/*********** Test from M ***********/
	//
	result = [ConversionTool convertDistance:initialValue from:kMeters to:kNautic];
	STAssertEqualsWithAccuracy(result, expectedValue, kDistAccuracy, @"-100 Meters to nautic Failed");
}

- (void) testLimitCasesTemperature {

	CGFloat initialValue = 0;
	CGFloat expectedValue = -273.15;
	CGFloat result = 0;
	
	//0 kelvin = -273.15 degrees Celsius
	result = [ConversionTool convertTemperature:initialValue from:kKelvin to:kCelsius];
	STAssertEqualsWithAccuracy(result, expectedValue, kTempAccuracy, @"0 Kelvin in C");
}


@end
