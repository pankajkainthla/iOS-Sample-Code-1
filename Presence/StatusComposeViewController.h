//
//  StatusComposeViewController.h
//  Presence
//
//  Created by Sergio on 6/29/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatusComposeViewControllerDelegate;

@interface StatusComposeViewController : UIViewController <UITextFieldDelegate> {
	UITextField *textField; //the text field
	UILabel *countdown;
	id<StatusComposeViewControllerDelegate> delegate;
}
@property (retain) UITextField *textField;
@property (assign) id<StatusComposeViewControllerDelegate> delegate;
@end
@protocol StatusComposeViewControllerDelegate <NSObject>
@optional
- (void) typed:(StatusComposeViewController *)controller somethingTyped:(NSString *)text;
- (void) soCancel;
- (void) soSend;
@end
