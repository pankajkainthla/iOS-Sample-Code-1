//
//  WhatsNext.h
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonDefine.h"

@class WNViewController;
@class WhatsNextWindow;

@interface WhatsNext : NSObject <UIApplicationDelegate> {
    WhatsNextWindow *window;
	WNViewController *viewController;
	CFTimeInterval lastShake;
}

@property (nonatomic, retain) IBOutlet WhatsNextWindow *window;

- (void) validShake;
@end

