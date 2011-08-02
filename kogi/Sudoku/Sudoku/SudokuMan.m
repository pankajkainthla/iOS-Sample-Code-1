//
//  SudokuMan.m
//  Sudoku
//
//  Created by Sergio Botero on 7/28/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuMan.h"

@implementation SudokuMan

@synthesize grid00, grid01, grid02, grid10, grid11, grid12, grid20, grid21, grid22;


- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

//- (kGridPosition) translatePositionToGrid:()

- (void) toggleNumber:(int) number toPositionI:(int) iPos andJ:(int) jPos {

	if (iPos <= 2) {
		if (jPos <= 2) {
			grid00 ^= (1 << number);
			NSLog(@"%d", grid00);
		}else if (jPos <= 5){ 
			grid01 ^= (1 << number);
			NSLog(@"%d", grid01);
		}else{
			grid02 ^= (1 << number);
			NSLog(@"%d", grid02);
		}
		
	}else if (iPos <= 5){ 
		if (jPos <= 2) {
			grid10 ^= (1 << number);
			NSLog(@"%d", grid10);
		}else if (jPos <= 5){ 
			grid11 ^= (1 << number);
			NSLog(@"%d", grid11);
		}else{
			grid12 ^= (1 << number);
			NSLog(@"%d", grid12);
		}
		
	}else{
		if (jPos <= 2) {
			grid20 ^= (1 << number);
			NSLog(@"%d", grid20);
		}else if (jPos <= 5){ 
			grid21 ^= (1 << number);
			NSLog(@"%d", grid21);
		}else{
			grid22 ^= (1 << number);
			NSLog(@"%d", grid22);
		}
	}
	
	
	
}


- (NSArray *) usedNumbersArrayForGrid:(int) kGridPosition {

	NSMutableArray * usedNumbersArrayForGrid = [[NSMutableArray alloc] init];
	
	switch (kGridPosition) {
		case kGridPosition00:
			
			for(int i = 0; i < 10; ++i){
				if (grid00 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition01:
			
			for(int i = 0; i < 10; ++i){
				if (grid01 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;

		case kGridPosition02:
			
			for(int i = 0; i < 10; ++i){
				if (grid02 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition10:
			
			for(int i = 0; i < 10; ++i){
				if (grid10 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition11:
			
			for(int i = 0; i < 10; ++i){
				if (grid11 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition12:
			
			for(int i = 0; i < 10; ++i){
				if (grid12 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition20:
			
			for(int i = 0; i < 10; ++i){
				if (grid20 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition21:
			
			for(int i = 0; i < 10; ++i){
				if (grid21 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
			
		case kGridPosition22:
			
			for(int i = 0; i < 10; ++i){
				if (grid22 & (1<<i)) {
					[usedNumbersArrayForGrid addObject:[NSNumber numberWithInt:(i+1)]];
				}
			}
			
			break;
	}
	
	return [usedNumbersArrayForGrid autorelease];
}


@end
