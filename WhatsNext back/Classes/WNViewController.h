//
//  WNViewController.h
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhatsNextGen.h"
#import "commonDefine.h"

@interface WNViewController : UIViewController {
	UIView * mainView;
	UILabel * mainLabel;
	int currentCategory;
}

- (void) saySomething;

@end
