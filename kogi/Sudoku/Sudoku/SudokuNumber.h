//
//  SudokuNumber.h
//  Sudoku
//
//  Created by Sergio Botero on 7/28/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

struct SBSudokuGrid {
	int i;
	int j;
};
typedef struct SBSudokuGrid SBSudokuGrid;

@interface SudokuNumber : NSObject

@property (nonatomic, retain) NSNumber * numberValue;
@property (nonatomic) SBSudokuGrid gridPosition;

- (id) initWithNumber:(NSNumber *) number andPosition:(SBSudokuGrid) grid;

@end