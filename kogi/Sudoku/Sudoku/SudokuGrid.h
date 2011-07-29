//
//  SudokuGrid.h
//  Sudoku
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuNumber.h"

@interface SudokuGrid : UIView 
{
	CGFloat vSpace;
	CGFloat hSpace;
	CGFloat spacing;
	
	CGRect currentBounds;
	
	NSMutableDictionary * numbersDrawn;
	
}

- (void) drawNumber:(int) number;

@property (nonatomic) SBSudokuGrid highlightedCell;


@end
