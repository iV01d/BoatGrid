//
//  BoatSquare.m
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import "BoatSquare.h"

@interface BoatSquare()
@property (nonatomic, readwrite) BOOL isBoat;
@end

@implementation BoatSquare

@synthesize isBoat, x = _x, y = _y, distances = _distances, sqaureColor = _sqaureColor;

-(NSString *) description
{
    NSString *ret;
    if (!_x || !_y)
    {
        ret = @"?,?";
    } else if (self.isBoat)
    {
        ret = [NSString stringWithFormat:@"%li, %li & Is A Boat", _x, _y];
    } else {
        ret = [NSString stringWithFormat:@"%li, %li", _x, _y];
    }
    return ret;
}

-(NSMutableArray *) distances
{
    if (_distances == nil)
    {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        _distances = arr;
    }
    
    return _distances;
}

-(UIColor*) sqaureColor
{
    if (_sqaureColor == nil)
    {
        UIColor *color = [UIColor whiteColor];
        _sqaureColor = color;
    }
    
    return _sqaureColor;
}

-(int)setSquareToBoat
{
    if (isBoat == TRUE)
        return 1;
    else
    {
        isBoat = TRUE;
        return 0;
    }
}

-(int)removeBoatFromSquare
{
    if (isBoat == FALSE)
        return 1;
    else
    {
        isBoat = FALSE;
        return 0;
    }
}

#pragma mark - Initialisation

-(instancetype) initWithX:(NSInteger)x andY:(NSInteger)y
{
    self = [super init];
    
    if (self)
    {
        _x = x;
        _y = y;
    }
    
    return self;
}

#pragma mark - Calculation

-(NSUInteger) calculateDistanceToSquare:(BoatSquare *)square
{
    NSInteger heightOff = square.x - self.x;
    NSInteger lengthOff = self.y - square.y;
    
    NSInteger result = labs(heightOff) + labs(lengthOff);
    
    if (result < 0)
    {
        result = labs(result);
        return result;
    }
    
    return result;
}

@end
