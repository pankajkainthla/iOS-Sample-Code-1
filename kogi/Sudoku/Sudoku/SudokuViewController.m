//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuViewController.h"
#import "SudokuGrid.h"

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
	
	CGFloat startPoint = 20;
	CGRect bounds = self.view.bounds;
	CGRect frame = CGRectMake(startPoint, startPoint, bounds.size.width - 2*startPoint, bounds.size.height - 6*startPoint); 
	SudokuGrid * mview = [[SudokuGrid alloc] initWithFrame:frame];
	[self.view addSubview:mview];
	[mview release];
}

@end
