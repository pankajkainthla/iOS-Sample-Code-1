//
//  SelectionViewController.h
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversionViewController.h"


@interface SelectionViewController : UIViewController {
	ConversionViewController * conversionController;
}

- (IBAction) buttonPressed:(id)sender;
@end
