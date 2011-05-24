//
//  MorseBlinkerAppDelegate.h
//  MorseBlinker
//
//  Created by Sergio on 3/25/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "textCreationView.h"

@interface MorseBlinkerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	textCreationView *sbview;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

