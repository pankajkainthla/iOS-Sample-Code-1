//
//  StatusComposeViewController.m
//  Presence
//
//  Created by Sergio on 6/29/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import "StatusComposeViewController.h"


@implementation StatusComposeViewController
@synthesize delegate;
@synthesize textField;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *cancelB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(soCancel)];
	UIBarButtonItem *sendB = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonSystemItemDone target:self action:@selector(soSend)];
	
	self.navigationItem.rightBarButtonItem = sendB;
	self.navigationItem.leftBarButtonItem = cancelB;
	
	[sendB release];
	[cancelB release];
}

- (void)dealloc {
//	NSLog(@"status composer dealloc");
	textField.delegate = nil;
	self.delegate = nil;
	[countdown release];
	[textField release];
    [super dealloc];
}

#pragma mark -
#pragma mark My implementations

- (void)loadView {
	// the creation
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake( 10 , 40, 30, 50) ];	
	textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, contentView.frame.size.width-20, 50)];
	countdown = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.size.width-30, textField.frame.size.height+textField.frame.origin.y+10, 50, 15)];	
	//label setup
	[countdown setTextColor:[UIColor grayColor]];
	[countdown setText:@"140"];
	[label setText:@"What are you doing right now?"];
	[label setNumberOfLines:1];
	[label sizeToFit];
	CGRect newFrame = label.frame;
	newFrame.origin.x = (contentView.frame.size.width/2) - (label.frame.size.width/2);
	label.frame = newFrame;
	
	//text field setup
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.delegate = self;
	[textField setPlaceholder:@"Write your status here!!..."];
	
	//content view setup
	[contentView addSubview:countdown];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	[contentView addSubview:textField];
	[contentView addSubview:label];	

	//view setup
	self.view = contentView;
	self.title = @"Status";	
	//release

	[label release];
	[contentView release];
}


//canceling the status update
-(void)soCancel{
	self.navigationItem.prompt = nil;
	if ([self.delegate respondsToSelector:@selector(typed:somethingTyped:)])
		[self.delegate typed:self somethingTyped:nil];
}

//send the new status to the ultra-super-information-highway
-(void)soSend{
	if(textField.text != nil){
		self.navigationItem.prompt = nil;
		if ([self.delegate respondsToSelector:@selector(typed:somethingTyped:)]){
			[self.delegate typed:self somethingTyped:textField.text];
		}

	}else{
		self.navigationItem.prompt = @"Set you status first";
	}
}

//no need to bother with another delegate for the textfield,  just add on the .h and make this class the textfield's delegate
- (BOOL)textField:(UITextField *)localTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	[countdown setText:[NSString stringWithFormat:@"%d",140-textField.text.length]];
	if (localTextField.text.length >= 140 && range.length == 0)
        return NO;
	[countdown setText:[NSString stringWithFormat:@"%d",140-textField.text.length]];
    return YES;
}

@end