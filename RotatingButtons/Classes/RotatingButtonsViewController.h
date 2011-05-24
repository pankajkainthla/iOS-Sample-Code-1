//
//  RotatingButtonsViewController.h
//  RotatingButtons
//
//  Created by Sergio on 6/9/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RotatingButtonsViewController : UIViewController <UIAccelerometerDelegate>{
	UILabel *labelView;
	UIButton *first,*second,*third;	
}

- (void)rotateButtons;
- (void)yeah:(id)sender;

@end

