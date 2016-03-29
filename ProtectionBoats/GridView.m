//
//  GridView.m
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import "GridView.h"
#import "BoatSquare.h"
#import "UIColor+LighterAndDarker.h"

@interface GridView()

@property (nonatomic) NSInteger rows, cols;
@property (nonatomic) NSInteger numberOfBoats;
@property (nonatomic, strong) NSMutableOrderedSet *boats;

@end

@implementation GridView

-(instancetype) initWithNumberOfRows:(NSInteger)rows andCols:(NSInteger)cols
{
    self = [super init];
    
    if (self)
    {
        self.rows = rows;
        self.cols = cols;
    }
    
    return self;
}

-(NSArray *) generateBoatsForGrid
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    // Rows
    for (int x = 1; x <= self.rows; x++)
    {
        //NSLog(@"Rows: %i", x);
        for (int y = 1;  y <= self.cols; y++)
        {
            NSUInteger boatX;
            NSUInteger boatY;
            BOOL doBreak = NO;
            for (BoatSquare *boat in self.boats)
            {
                boatX = boat.x;
                boatY = boat.y;
                if (x == boatX && y == boatY)
                {
                    doBreak = true;
                    break;
                }
            }
            
            if (doBreak == true)
            {
                // Nothing
            }
            else
            {
                //NSLog(@"Columns: %i", y);
                BoatSquare *rowBoat = [[BoatSquare alloc] initWithX:x andY:y];
                [result addObject:rowBoat];
            }
        }
    }
    
    return result;
}

-(NSMutableOrderedSet *) boats
{
    if (_boats == nil)
        _boats = [[NSMutableOrderedSet alloc] init];
    
    return _boats;
}

-(void) addBoat:(BoatSquare *)boat
{
    if (boat == nil)
        return;
    else if (self.boats.count > (self.rows * self.cols))
        return;
    else if (boat.x > self.rows || boat.y > self.cols)
        return;
    
    [self.boats addObject:boat];
    self.numberOfBoats++;
}

-(void) setGridColTo:(int)col andRowsTo:(int)rows
{
    self.rows = rows;
    NSLog(@"Rows set to: %i", rows);
    self.cols = col;
    NSLog(@"Cols set to: %i", col);
    [self setNeedsDisplay];
}

-(void) setGridColsTo:(NSInteger)col
{
    self.cols = col;
    NSLog(@"Cols set to: %li", col);
    [self setNeedsDisplay];
}

-(void) setGridRowsTo:(NSInteger)rows
{
    self.rows = rows;
    NSLog(@"Rows set to: %li", rows);
    [self setNeedsDisplay];
}

#pragma mark - Drawing

-(void) drawRect:(CGRect)rect
{
    UIBezierPath *box = [UIBezierPath bezierPathWithRect:self.bounds];
    
    box.lineWidth = 3;
    
    [[UIColor whiteColor] setFill];
    [box fill];
    
    //NSArray *squares = [self generateBoatsForGrid];  // Array containing all the grid squares
    
    // Draw Boats
    [self drawBoatsWithRect:rect];
    
    [[UIColor blackColor] setStroke];
    [box stroke];
    
    //[self drawCalculatedSquaresInRect:rect withArrayOfSquares:squares];
    
    UIBezierPath *rowsLine = [UIBezierPath bezierPath];
    
    for (int i = 1; i < self.rows; i++)
    {
        CGPoint ptR = CGPointMake(((rect.size.width / self.rows) * i), 0);
        [rowsLine moveToPoint:ptR];
        [rowsLine addLineToPoint:CGPointMake(ptR.x, rect.size.height)];
        [rowsLine stroke];
        [rowsLine fill];
    }
    
    UIBezierPath *colsLine = [UIBezierPath bezierPath];
    
    for (int i = 1; i < self.cols; i++)
    {
        CGPoint ptC = CGPointMake(0, (rect.size.height / self.cols) * i);
        [colsLine moveToPoint:ptC];
        [colsLine addLineToPoint:CGPointMake(rect.size.width, ptC.y)];
        [colsLine stroke];
        [colsLine fill];
    }
}

-(void) drawBoatsWithRect:(CGRect) rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *fontAwesome = [UIFont fontWithName:@"FontAwesome" size:24];
    
    NSAttributedString *boatString = [[NSAttributedString alloc] initWithString:@"\uf21a"
                                                                     attributes:@{ NSFontAttributeName : fontAwesome,
                                                                                   NSParagraphStyleAttributeName : paragraphStyle }];
    
    for (BoatSquare *boat in self.boats)
    {
        if (boat.x && boat.y)
        {
            CGRect boatRect = CGRectMake((rect.size.width / self.rows) * (boat.x - 1), (rect.size.height / self.cols) * (boat.y - 1), rect.size.width / self.rows, rect.size.height / self.cols);
            
            //CGRect boatRect = CGRectMake(0, 0, (rect.size.height / self.rows), (rect.size.height / self.cols));
            
            UIBezierPath *boatRectPath = [UIBezierPath bezierPathWithRect:boatRect];
            [[UIColor cyanColor] setFill];
            [boatRectPath fill];
            
            CGRect textRect = CGRectMake(boatRect.origin.x, boatRect.origin.y + (boatRect.size.height / 3), boatRect.size.width, boatRect.size.height);
            [boatString drawInRect:textRect];
        }
    }
}

#pragma mark - Doesn't Work Yet
/*
-(void) drawCalculatedSquaresInRect:(CGRect) rect withArrayOfSquares:(NSArray *)arrayOfSquares
{
    if (self.boats.count > 2)
    {
        for (BoatSquare *square in arrayOfSquares)
        {
            NSMutableArray *boatSquareStore =[[NSMutableArray alloc] init];
            for (BoatSquare *boat in self.boats)
            {
                NSUInteger distanceUInt = [square calculateDistanceToSquare:boat];
                NSNumber *distance = [[NSNumber alloc] initWithLong:distanceUInt];
                [boatSquareStore addObject: distance];
                
                if ([boatSquareStore objectAtIndex:0] == [boatSquareStore objectAtIndex:1])
                {
                    NSLog(@"Yes, %@, %@",[boatSquareStore objectAtIndex:0], [boatSquareStore objectAtIndex:1]);
                    CGRect matchSquare = CGRectMake((rect.size.width / self.rows) * (square.x - 1), (rect.size.height / self.cols) * (square.y - 1), rect.size.width / self.rows, rect.size.height / self.cols);
                    
                    UIBezierPath *matchedSquarePath = [UIBezierPath bezierPathWithRect:matchSquare];
                    [[UIColor grayColor] setFill];
                    [matchedSquarePath fill];
                }
            }
        }
    }
}
 */

@end
