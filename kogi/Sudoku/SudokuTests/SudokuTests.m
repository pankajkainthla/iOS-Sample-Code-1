//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuTests.h"

#import "SudokuMan.h"

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
	
	SudokuMan * sudokuMan = [[SudokuMan alloc]init];

	[sudokuMan release];
}

@end
