//
//  BoatSquare.h
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@interface BoatSquare : NSObject

@property (nonatomic, readonly) BOOL isBoat;
@property (nonatomic) NSUInteger x;
@property (nonatomic) NSUInteger y;
@property (nonatomic, strong) NSMutableArray *distances; // Distance to boats
@property (nonatomic, strong) UIColor *sqaureColor;

-(instancetype) initWithX:(NSInteger) x andY:(NSInteger) y;
-(int) setSquareToBoat;
-(int) removeBoatFromSquare;
-(NSUInteger) calculateDistanceToSquare:(BoatSquare *) square;

@end
