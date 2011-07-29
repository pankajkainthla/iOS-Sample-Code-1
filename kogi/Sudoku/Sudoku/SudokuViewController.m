//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuViewController.h"

@interface SudokuViewController ()
	- (void) restrictNumbers:(NSArray *) selectedNumbers ;
@end

@implementation SudokuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

	}
    return self;
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	buttonsArray = [[NSArray alloc] initWithObjects:button1,button2, button3 ,button4 ,button5 ,button6 ,button7 ,button8 ,button9, nil];
	
	CGFloat startPoint = 20;
	CGRect bounds = self.view.bounds;
	CGRect frame = CGRectMake(startPoint, startPoint, bounds.size.width - 2*startPoint, bounds.size.height - 6*startPoint); 
	sudoView = [[SudokuGrid alloc] initWithFrame:frame];
	[self.view addSubview:sudoView];
	[sudoView release];
	
	sudoMan = [[SudokuMan alloc] init];
}

// TODO: --
- (IBAction) selectNumber:(id) sender {
	
	int number = [sender tag];

	[sudoView drawNumber: number];
	
	//	[sudoMan toggleNumber:number toPositionI:sudoView.highlightedCell.i andJ:sudoView.highlightedCell.j];
	
	//	[self restrictNumbers: [sudoMan usedNumbersArrayForGrid:0]];
	
}

- (void) restrictNumbers:(NSArray *) selectedNumbers {

	for (int i = 0; i < [buttonsArray count]; ++i) {
		[[buttonsArray objectAtIndex:i] setEnabled:YES];
	}
	
	for (NSNumber * value in selectedNumbers) {
		[[buttonsArray objectAtIndex:([value intValue] - 1)] setEnabled:NO];
	}
	
}

@end
