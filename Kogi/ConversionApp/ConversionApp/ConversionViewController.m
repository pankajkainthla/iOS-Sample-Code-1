//
//  TemperatureViewController.m
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "ConversionViewController.h"
#import "ConversionTool.h"

@implementation ConversionViewController

@synthesize conversionType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPeriodButton) name:UIKeyboardDidShowNotification object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePeriodButton) name:UIKeyboardWillHideNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateValues:) name:UITextFieldTextDidChangeNotification object:nil];
		
		
		periodButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 427 , 105, 53)];
		[periodButton addTarget:self action:@selector(addPeriod) forControlEvents:UIControlEventTouchUpInside];
		
		[periodButton setTitle:@"." forState:UIControlStateNormal];
		periodButton.titleLabel.font = [UIFont systemFontOfSize:36.0];
		
		[periodButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		
    }
    return self;
}

- (void)dealloc
{
	[periodButton release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
	
	[fromUnitsSegment setSelectedSegmentIndex:0];
	[toUnitsSegment setSelectedSegmentIndex:0];
	[valueInput becomeFirstResponder];
	valueInput.text = @"0";
	conversionResultLabel.text = @"0";
	
	if (self.conversionType == 1) {
		self.title = @"temperature";
		[fromUnitsSegment setTitle:@"C" forSegmentAtIndex:0];
		[fromUnitsSegment setTitle:@"F" forSegmentAtIndex:1];
		[fromUnitsSegment setTitle:@"K" forSegmentAtIndex:2];

		[toUnitsSegment setTitle:@"C" forSegmentAtIndex:0];
		[toUnitsSegment setTitle:@"F" forSegmentAtIndex:1];
		[toUnitsSegment setTitle:@"K" forSegmentAtIndex:2];

	} else if (self.conversionType == 2) {
		self.title = @"longitude";
		[fromUnitsSegment setTitle:@"meters" forSegmentAtIndex:0];
		[fromUnitsSegment setTitle:@"nautic" forSegmentAtIndex:1];
		[fromUnitsSegment setTitle:@"yards" forSegmentAtIndex:2];
		
		[toUnitsSegment setTitle:@"meters" forSegmentAtIndex:0];
		[toUnitsSegment setTitle:@"nautic" forSegmentAtIndex:1];
		[toUnitsSegment setTitle:@"yards" forSegmentAtIndex:2];

	}
	
}

- (IBAction) changeSign:(id)sender {
	
	CGFloat currentValue = [valueInput.text floatValue];
	if (currentValue != 0) {
		currentValue *= -1;
		valueInput.text = [NSString stringWithFormat:@"%f", currentValue];
	}
}

- (IBAction) updateValues:(id)sender {
	int fromUnit = 0, toUnit = 0;
	switch (fromUnitsSegment.selectedSegmentIndex) {
		case 0:
			fromUnit = (self.conversionType == 1)? kCelsius : kMeters;
			break;
		case 1:
			fromUnit = (self.conversionType == 1)? kFahrenheit : kNautic;
			break;
		case 2:
			fromUnit = (self.conversionType == 1)? kKelvin : kYards;
			break;
	}

	switch (toUnitsSegment.selectedSegmentIndex) {
		case 0:
			toUnit = (self.conversionType == 1)? kCelsius : kMeters;
			break;
		case 1:
			toUnit = (self.conversionType == 1)? kFahrenheit : kNautic;
			break;
		case 2:
			toUnit = (self.conversionType == 1)? kKelvin : kYards;
			break;
	}
	
	
	CGFloat result = 0;
	CGFloat value = [valueInput.text floatValue];
	
	if(self.conversionType == 1){
		result = [ConversionTool convertTemperature:value from:fromUnit to:toUnit];
	} else if(self.conversionType == 2){
		result = [ConversionTool convertDistance:value from:fromUnit to:toUnit];
	}
	conversionResultLabel.text = [NSString stringWithFormat:@"%f", result];
		
	
}

- (void) showPeriodButton {

	NSArray *allWindows = [[UIApplication sharedApplication] windows];
	int topWindow = [allWindows count] - 1;
	UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
	
	[keyboardWindow addSubview:periodButton];	
}

- (void) hidePeriodButton { 
	[periodButton removeFromSuperview];
}

- (void) addPeriod {
	NSString * currentText = valueInput.text;
	
	if ([[currentText componentsSeparatedByString:@"."] count] <= 1) {
		valueInput.text = [currentText stringByAppendingString:@"."];
	}
}

@end
