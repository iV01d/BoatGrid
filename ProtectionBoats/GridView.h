//
//  GridView.h
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoatSquare;

@interface GridView : UIView

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithNumberOfRows:(NSInteger) rows andCols:(NSInteger) cols;

-(void) addBoat:(BoatSquare *)boat;
-(void) setGridColTo:(int) col andRowsTo:(int) rows;
-(void) setGridColsTo:(NSInteger) col;
-(void) setGridRowsTo:(NSInteger) rows;

@end
