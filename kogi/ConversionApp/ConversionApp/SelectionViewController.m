//
//  SelectionViewController.m
//  ConversionApp
//
//  Created by Sergio Botero on 7/16/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SelectionViewController.h"

@implementation SelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		conversionController = [[ConversionViewController alloc]init];
	}
    return self;
}

- (void)dealloc
{
	[conversionController release];
    [super dealloc];
}

- (IBAction) buttonPressed:(id)sender {
	conversionController.conversionType = [sender tag];
	[self.navigationController pushViewController:conversionController animated:YES];
}

@end
