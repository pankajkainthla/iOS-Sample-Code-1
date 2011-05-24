//
//  Simple_FormAppDelegate.h
//  Simple Form
//
//  Created by Sergio Botero on 4/4/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleForm.h"
@interface Simple_FormAppDelegate : NSObject <UIApplicationDelegate> {
	SimpleForm * simple_form;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
