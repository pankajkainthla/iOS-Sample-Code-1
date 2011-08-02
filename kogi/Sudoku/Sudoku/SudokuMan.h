//
//  SudokuMan.h
//  Sudoku
//
//  Created by Sergio Botero on 7/28/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	kGridPosition00 = 0,
	kGridPosition01 = 1,
	kGridPosition02 = 2,
	
	kGridPosition10 = 3,
	kGridPosition11 = 4,
	kGridPosition12 = 5,

	kGridPosition20 = 6,
	kGridPosition21 = 7,
	kGridPosition22 = 8,

} kGridPosition;


@interface SudokuMan : NSObject

@property (nonatomic) int grid00;
@property (nonatomic) int grid01;
@property (nonatomic) int grid02;

@property (nonatomic) int grid10;
@property (nonatomic) int grid11;
@property (nonatomic) int grid12;

@property (nonatomic) int grid20;
@property (nonatomic) int grid21;
@property (nonatomic) int grid22;

- (void) toggleNumber:(int) number toPositionI:(int) iPos andJ:(int) jPos;
- (NSArray *) usedNumbersArrayForGrid:(int) kGridPosition;

@end
