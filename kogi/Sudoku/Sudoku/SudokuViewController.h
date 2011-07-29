//
//  SudokuViewController.h
//  Sudoku
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SudokuMan.h"
#import "SudokuGrid.h"

@interface SudokuViewController : UIViewController {

	SudokuGrid * sudoView;
	SudokuMan * sudoMan;
	
	NSArray * buttonsArray;
	
	IBOutlet UIButton * button1;
	IBOutlet UIButton * button2;
	IBOutlet UIButton * button3;
	IBOutlet UIButton * button4;
	IBOutlet UIButton * button5;
	IBOutlet UIButton * button6;
	IBOutlet UIButton * button7;
	IBOutlet UIButton * button8;
	IBOutlet UIButton * button9;
	
}

- (IBAction) selectNumber:(id) sender;

@end
