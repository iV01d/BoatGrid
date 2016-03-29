//
//  BoatSquare.h
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoatSquare : NSObject

@property (nonatomic, readonly) BOOL isBoat;
@property (nonatomic) NSUInteger x;
@property (nonatomic) NSUInteger y;

-(instancetype) initWithX:(NSInteger) x andY:(NSInteger) y;
-(int) setSquareToBoat;
-(int) removeBoatFromSquare;
-(NSUInteger) calculateDistanceToSquare:(BoatSquare *) square;

@end
