//
//  textCreationView.m
//  MorseBlinker
//
//  Created by Sergio on 3/25/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import "textCreationView.h"


@implementation textCreationView


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization 
 // that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization

    }
    return self;
}*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

	CGRect screen_bounds = [[UIScreen mainScreen] applicationFrame];
	UIColor * back_color = [[UIColor alloc] initWithRed:(CGFloat)(211/255.0) green:(CGFloat)(211/255.0)
												   blue:(CGFloat)(211/255.0) alpha:(CGFloat)1];
	[self init_all_views];
	running_blink = NO;
	CGFloat y_position = (CGFloat)40;
	
	info_label = [[UILabel alloc]initWithFrame:CGRectMake( 10 , y_position, screen_bounds.size.width - 20, 0)];
	[info_label setText:NSLocalizedString(@"info_label_text",@"Info before the text field (label)")];
	[info_label setBackgroundColor:back_color];
	[info_label sizeToFit];
	
	count_label = [[UILabel alloc] initWithFrame:CGRectMake(screen_bounds.size.width-info_label.frame.size.width,
															y_position, SIGNED_3_DIGIT, DIGIT_12pt_HEIGHT) ];
	[count_label setText:[NSString stringWithFormat:@"%d",MAX_LENGTH_TEXT]];
	[count_label setBackgroundColor:back_color];
	[count_label setTextAlignment:UITextAlignmentRight];

	
	y_position+=info_label.frame.size.height+SPACER;
	text_input = [[UITextField alloc] initWithFrame:CGRectMake( 10 , y_position,screen_bounds.size.width - 20 , 60 )];
	[text_input setBorderStyle:UITextBorderStyleRoundedRect];
	[text_input setFont:[UIFont fontWithName:@"Helvetica" size:(CGFloat)34]];
	text_input.keyboardType= UIKeyboardTypeNamePhonePad;
	text_input.returnKeyType=UIReturnKeyDone;
	text_input.autocorrectionType = UITextAutocorrectionTypeNo;
	text_input.enablesReturnKeyAutomatically =YES;
	text_input.adjustsFontSizeToFitWidth = YES;
	text_input.delegate=self;
/*	
		done_label = [[UILabel alloc] initWithFrame:CGRectMake( 0 ,0,500,500)];
	//done_label = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame ]];
	[done_label setBackgroundColor:[UIColor blackColor]];
	[done_label setTextColor:[UIColor whiteColor]];
	[done_label setText:NSLocalizedString(@"done_label_text",@"message for tap to done")];
		//	[done_label sizeToFit];
	done_label.center = CGPointMake(screen_bounds.size.width/2.0, screen_bounds.size.height/2.0);
	done_label.textAlignment = UITextAlignmentCenter;
*/
	
	/*
	 y_position+=preview_label.frame.size.height+SPACER;
	 blinkit_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	 [blinkit_button addTarget:self action:@selector(action_happens) forControlEvents:UIControlEventTouchDown];
	 [blinkit_button setTitle:NSLocalizedString(@"button_text",@"") forState:UIControlStateNormal];
	 blinkit_button.frame = CGRectMake(screen_bounds.size.width-90, 20+y_position, 80, 80);
	 [blinkit_button sizeToFit];
	 */

	int full_resize_mask = (1<<6)-1;
		//	[done_label setAutoresizingMask:(full_resize_mask)];//- (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth))];
	[text_input setAutoresizingMask:(full_resize_mask)];
	[info_label setAutoresizingMask:(full_resize_mask)];
	[count_label setAutoresizingMask:(full_resize_mask)];
	
	[compose_phrase setBackgroundColor:back_color];
	[compose_phrase addSubview:count_label];
	[compose_phrase addSubview:info_label];
	[compose_phrase addSubview:text_input];
	self.view = compose_phrase;
	self.view.autoresizesSubviews = YES;
	[back_color release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
		//return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||	(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	if(running_blink)
		return NO;
	return YES;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent*)event{
	if (running_blink) {
			//[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
		running_blink = NO;
		[black_view removeFromSuperview];
		[white_view removeFromSuperview];
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[white_view release];

	[black_view release];
	[compose_phrase release];
	[text_input release];
	
	[preview_label release];
	[info_label release];

	[super dealloc];
}

#pragma mark -
#pragma mark Delegate methods

	//Updates from the textfield text
- (BOOL)
textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	aux_txt_field = [[UITextField alloc]init];
	[aux_txt_field setText:[text_input.text stringByReplacingCharactersInRange:range withString:string]];
	current_length=[aux_txt_field.text length];
	[count_label setText:[NSString stringWithFormat:@"%d",MAX_LENGTH_TEXT - current_length ]];
	
	if( MAX_LENGTH_TEXT < current_length ){
		[count_label setTextColor:[UIColor redColor]];
	}else{
		[count_label setTextColor:[UIColor blackColor]];
	}
	[aux_txt_field release];
	return YES;
}


	//Action for the return button on keyboard
- (BOOL)
textFieldShouldReturn:(UITextField *)textField
{
	if ( (MAX_LENGTH_TEXT < [textField.text length]) ) {
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert_title", @"No more characters")
									message:[NSString stringWithFormat:@"%@ %d.",NSLocalizedString(@"alert_msg",@"error message"),
									MAX_LENGTH_TEXT]
									delegate:nil
									cancelButtonTitle:NSLocalizedString(@"ack",@"ok button on alert")
									otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}else {
		[textField resignFirstResponder];
		[NSThread detachNewThreadSelector:@selector(start_blinking_phone) toTarget:self withObject:nil];//
	}
	return YES;
}



#pragma mark -
#pragma mark Custom methods

	//Init basics //CGRectMake(0, 0, 320, 480)
-(void)
init_all_views
{
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	compose_phrase = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	compose_phrase.autoresizesSubviews = YES;
	
		//	black_view = [[UILabel alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame] ];
	white_view = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[white_view setBackgroundColor:[UIColor whiteColor]];
		//white_view.autoresizingMask =  (((1<<6)-1));//- (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth));
		//	white_view.center = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2.0, [[UIScreen mainScreen] applicationFrame].size.height/2.0);

		//	black_view = [[UILabel alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame] ];
	black_view = [[UILabel alloc]initWithFrame:[UIScreen mainScreen].bounds];
	[black_view setBackgroundColor:[UIColor blackColor]];
		//black_view.autoresizingMask = (((1<<6)-1));//-(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth));
		//black_view.center = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2.0, [[UIScreen mainScreen] applicationFrame].size.height/2.0);

	
	
	[black_view setTextColor:[UIColor grayColor]];
	[black_view setText:NSLocalizedString(@"done_label_text",@"message for tap to done")];
	black_view.textAlignment = UITextAlignmentCenter;
	
	[white_view setTextColor:[UIColor grayColor]];
	[white_view setText:NSLocalizedString(@"done_label_text",@"message for tap to done")];
	white_view.textAlignment = UITextAlignmentCenter;
 


}


	//Thread that sleeps for morse code sense
-(void)
start_blinking_phone
{
	NSAutoreleasePool * thread_pool = [[NSAutoreleasePool alloc] init ];
	NSDictionary *morse_codes=[NSDictionary dictionaryWithDictionary:[MorseCode create_morse_dictionary]];
	running_blink = YES;
	[text_input setEnabled:NO];
	int text_len = [text_input.text length] ,letter_form_ln, dot_or_dash=-1;
	[self performSelectorOnMainThread:@selector(inter_view_change:) withObject:[NSNumber numberWithInt:dot_or_dash]
						waitUntilDone:NO];
	[NSThread sleepForTimeInterval:TIME_UNIT*PAUSE_LETTER ];
	dot_or_dash *= -1;
	for (int letter=0; (letter<text_len) && running_blink; ++letter) {
		
		NSString * current_letter= [NSString stringWithFormat:@"%c",[text_input.text characterAtIndex:letter]];
		NSString * letter_form = [morse_codes objectForKey:current_letter];
		letter_form_ln = [letter_form length];
		for (int letter_index=0;  (letter_index<letter_form_ln) && running_blink; ++letter_index) {
			[self performSelectorOnMainThread:@selector(inter_view_change:) withObject:[NSNumber numberWithInt:dot_or_dash]
								waitUntilDone:NO];
			[NSThread sleepForTimeInterval:TIME_UNIT*([letter_form characterAtIndex:letter_index] - 48)];
			dot_or_dash *= -1;
			
		}
		[self performSelectorOnMainThread:@selector(inter_view_change:) withObject:[NSNumber numberWithInt:dot_or_dash]
							waitUntilDone:NO];
		[NSThread sleepForTimeInterval:TIME_UNIT*PAUSE_LETTER ];
		dot_or_dash *= -1;
	}
	[text_input setEnabled:YES];
	[thread_pool release];
}

	//Changes the view from BLACK to WHITE
-(void)
inter_view_change:(NSNumber *)next_view_int
{
	if (running_blink) {
		if ([next_view_int intValue] == WHITE ) {
			[self.view addSubview: white_view];
		}else if ([next_view_int intValue] == BLACK) {
			[self.view addSubview: black_view];
		}
	}
}

-(NSString *)
normalize_text:(NSString *)text_from_input
{
	NSString * normalized_text = [[NSString alloc] init] ;
	char aux ;
	for (int index=0; index<[text_from_input length]; ++index) {
		aux = [text_from_input characterAtIndex:index];
		if ( aux<='Z' && aux >='A') {
			[normalized_text stringByAppendingFormat:@"%c",aux+32];
		}else if ( (aux <='z' && aux>='a') ||  (aux <='9' && aux >='1') || aux == ' ' ) {
			[normalized_text stringByAppendingFormat:@"%c",aux];
		}
	}
	return [normalized_text autorelease];
}


@end

