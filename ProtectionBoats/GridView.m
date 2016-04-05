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
    
    if ([self.boats count] > 0)
    {
        NSArray *squares = [self createArrayContainingSquaresFromTheGrid];
        [self calculateDistancesWithSquaresFromArray:squares];
        [self drawCalculatedSquaresInRect:rect withArrayOfSquares:squares];
    }
    
    // Draw Boats
    [self drawBoatsWithRect:rect];
    
    [[UIColor blackColor] setStroke];
    [box stroke];
    
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

-(void) drawCalculatedSquaresInRect:(CGRect) rect withArrayOfSquares:(NSArray *)arrayOfSquares
{
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    for (int i = 0; i <= [self.boats count]; i++)
    {
        [colors addObject:[self randomColor]];
    }
    
    for (BoatSquare *square in arrayOfSquares)
    {
        NSNumber *gridSize = [[NSNumber alloc] initWithFloat:(self.cols * self.rows)];
        NSNumber *largestNumber = gridSize; // Get largest number
        for (long i = 0; i < [square.distances count]; i++)
        {
            NSNumber *value = [square.distances objectAtIndex:i];
            if (value < largestNumber)
            {
                largestNumber = value;
            }
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        UIFont *numberFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        NSAttributedString *distance = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", largestNumber]
                                                                       attributes:@{ NSFontAttributeName : numberFont,
                                                                                     NSParagraphStyleAttributeName : paragraphStyle}];
        
        CGRect numberRect = CGRectMake((rect.size.width / self.rows) * (square.x - 1), (rect.size.height / self.cols) * (square.y - 1), rect.size.width / self.rows, rect.size.height / self.cols);
        
        UIBezierPath *numberPath = [UIBezierPath bezierPathWithRect:numberRect];
        [[UIColor orangeColor] setFill];
        [numberPath fill];
        
        CGRect textRect = CGRectMake(numberRect.origin.x, numberRect.origin.y + (numberRect.size.height / 3), numberRect.size.width, numberRect.size.height);
        
        [distance drawInRect:textRect];
    }
}

-(NSArray *) createArrayContainingSquaresFromTheGrid
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSInteger x = 1; x <= self.rows; x++)
    {
        for (NSInteger yVal = 1; yVal <= self.cols; yVal++)
        {
            BoatSquare *square = [[BoatSquare alloc] init];
            //NSLog(@"y val: %li", y);
            
            square.x = x;
            square.y = yVal;
            
            if (square == nil)
                break;
            else
                [result addObject:square];
        }
    }
    
    //NSLog(@"Square Array: %@", result);
    
    return result;
}

-(void) calculateDistancesWithSquaresFromArray:(NSArray *) array
{
    for (BoatSquare *boats in self.boats)
    {
        for (BoatSquare *squares in array)
        {
            NSInteger distance = [squares calculateDistanceToSquare:boats];
            NSNumber *num = [[NSNumber alloc] initWithLong:distance];
            [squares.distances addObject: num];
        }
    }
     
    BoatSquare *b = [[BoatSquare alloc] initWithX:1 andY:2];
    NSInteger dis = [b calculateDistanceToSquare: [self.boats objectAtIndex:0]];
    NSLog(@"Distance for test: %ld", dis);
}

-(UIColor *)randomColor
{
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
}

@end
