//
//  TemperatureViewController.h
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConversionViewController : UIViewController <UITextFieldDelegate>{
    NSInteger conversionType;

	IBOutlet UILabel *conversionResultLabel;
	
	IBOutlet UITextField *valueInput;
	
	IBOutlet UISegmentedControl *fromUnitsSegment;

	IBOutlet UISegmentedControl *toUnitsSegment;
	
	IBOutlet UIButton *changeSignButton;
	
	UIButton * periodButton;

}
@property NSInteger conversionType;

@end
