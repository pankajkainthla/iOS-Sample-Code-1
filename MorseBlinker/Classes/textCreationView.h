//
//  textCreationView.h
//  MorseBlinker
//
//  Created by Sergio on 3/25/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MorseCode.h"
#define SPACER 10
#define MAX_LENGTH_TEXT 10
#define SIGNED_1_DIGIT 16
#define SIGNED_2_DIGIT 25
#define SIGNED_3_DIGIT 35
#define DIGIT_12pt_HEIGHT 21
#define WHITE 1
#define BLACK -1

#define ARR UIViewAutoresizingFlexibleTopMargin
#define ABJ UIViewAutoresizingFlexibleBottomMargin
#define IZQ UIViewAutoresizingFlexibleLeftMargin
#define DER UIViewAutoresizingFlexibleRightMargin
#define ALTO UIViewAutoresizingFlexibleHeight
#define ANCH UIViewAutoresizingFlexibleWidth




@interface textCreationView : UIViewController <UITextFieldDelegate> {
	UILabel * info_label,* preview_label,*count_label, * white_view, *black_view;
	UITextField *text_input,*aux_txt_field;
	UIView * compose_phrase;
	int current_length;
	bool running_blink , dictionary_loaded;
}

-(void)init_all_views;
-(void)start_blinking_phone;
-(void)inter_view_change:(NSNumber *)next_view_int;
-(NSString *)normalize_text:(NSString *)text_from_input;
@end
