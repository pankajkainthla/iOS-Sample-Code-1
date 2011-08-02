//
//  SudokuNumber.m
//  Sudoku
//
//  Created by Sergio Botero on 7/28/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuNumber.h"



@implementation SudokuNumber
@synthesize gridPosition;
@synthesize numberValue;

- (id) initWithNumber:(NSNumber *) number andPosition:(SBSudokuGrid) grid {
	self = [super init];
	if (self) {
		numberValue = number;
		gridPosition = grid;
	}
	return self;
}

@end
