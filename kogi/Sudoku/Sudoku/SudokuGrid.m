//
//  SudokuGrid.m
//  Sudoku
//
//  Created by Sergio Botero on 7/26/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SudokuGrid.h"

@interface SudokuGrid ()
- (SBSudokuGrid) gridPositionFromPoint:(CGPoint) point;
@end

@implementation SudokuGrid

@synthesize highlightedCell;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		highlightedCell.i = -1;
		highlightedCell.j = -1;

		currentBounds = self.bounds;
		vSpace = currentBounds.size.height/9.0;
		hSpace = currentBounds.size.width/9.0;
		spacing = 0;
	
		numbersDrawn = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc {
	
	[numbersDrawn release];
	
	[super dealloc];
}

- (void) drawSudokuGrid:(CGContextRef) context {

	CGFloat weakStroke = 0.8, stringStroke = 4;
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	
	CGContextSetLineWidth(context, weakStroke);
	for (int i = 0; i < 10; ++i) {
		if (i%3 == 0) {
			CGContextSetLineWidth(context, stringStroke);
		}
		CGContextMoveToPoint(context, CGRectGetMinX(currentBounds) + spacing, CGRectGetMinY(currentBounds) + spacing  + (vSpace*i));
		CGContextAddLineToPoint(context,  CGRectGetMaxX(currentBounds) - spacing, CGRectGetMinY(currentBounds) + spacing + (vSpace*i));
		CGContextStrokePath(context);
		CGContextSetLineWidth(context, weakStroke);
		
	}
	
	for (int j = 0; j < 10; ++j) {
		
		if (j%3 == 0) {
			CGContextSetLineWidth(context, stringStroke);
		}
		
		CGContextMoveToPoint(context, CGRectGetMinX(currentBounds) + spacing + (hSpace*j), CGRectGetMinY(currentBounds) + spacing);
		CGContextAddLineToPoint(context,  CGRectGetMinX(currentBounds) + spacing + (hSpace*j), CGRectGetMaxY(currentBounds) - spacing);
		CGContextStrokePath(context);
		CGContextSetLineWidth(context, weakStroke);
	}

}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context , currentBounds);

	[self drawSudokuGrid:context];
	
	if (highlightedCell.i != -1 && highlightedCell.j != -1) {
		
		CGRect cell = CGRectMake( hSpace * highlightedCell.j, vSpace * highlightedCell.i, hSpace, vSpace);
		CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0].CGColor);
		CGContextFillRect(context , cell);
	}
	
	
	for (SudokuNumber * numToDraw in [numbersDrawn allValues] ) {
		CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
		NSString * numberAsString = [numToDraw.numberValue stringValue];
		
		//CGRect cell = CGRectMake( hSpace * highlightedCell.j, vSpace * highlightedCell.i, hSpace, vSpace);
		//[numberAsString drawInRect:cell withFont:[UIFont systemFontOfSize:30.0]];
		int padding = 5;
		SBSudokuGrid position = numToDraw.gridPosition;
		CGPoint drawingPoint = CGPointMake( hSpace * position.j + padding, vSpace * position.i);
		[numberAsString drawAtPoint:drawingPoint withFont:[UIFont systemFontOfSize:35.0]];
	}
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint touchPoint;
	NSArray * touchesArray = [touches allObjects];
	if( [touchesArray count] == 1){
		touchPoint = [[touchesArray objectAtIndex:0] locationInView:self];
		highlightedCell = [self gridPositionFromPoint:touchPoint];
	}
	[self setNeedsDisplay];
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{}

- (SBSudokuGrid) gridPositionFromPoint:(CGPoint) point {

	SBSudokuGrid gridPos = { 0 , 0};

	gridPos.i = (int) (point.y / vSpace);
	gridPos.j = (int) (point.x / hSpace);

	return gridPos;
}

- (void) drawNumber:(int) number {
	
	SudokuNumber * newNum = [[SudokuNumber alloc] initWithNumber:[NSNumber numberWithInt:number] andPosition:highlightedCell];
	
	[numbersDrawn setObject:newNum forKey:[NSString stringWithFormat:@"%d%d", highlightedCell.i, highlightedCell.j]];
	[newNum release];
	
	[self setNeedsDisplay];
}

@end
