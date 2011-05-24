//
//  ModalView.h
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/4/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBModalViewDelegate;

@interface ModalView : UIViewController <UIScrollViewDelegate>{
	UIScrollView *scroll;
	UIImageView *imageView;
	NSOperationQueue * opQueue;
	NSString * imageUrl;
	id <SBModalViewDelegate> delegate;
}
- (id) initWithImage:(NSString *) image andDelegate:(id) sentDelegate;
@property (nonatomic, retain) id <SBModalViewDelegate> delegate;
@property (nonatomic, copy) NSString * imageUrl;
@end

@protocol SBModalViewDelegate <NSObject>
- (void) backFromModalWithImage:(UIImage *) image forUrl:(NSString *)url;
@end
