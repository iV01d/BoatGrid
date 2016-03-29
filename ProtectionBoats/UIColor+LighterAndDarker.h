//
//  UIColor+LighterAndDarker.h
//  ProtectionBoats
//
//  Created by Daniel Tucker on 28/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LighterAndDarker)

- (UIColor *)lighterColorForColor:(UIColor *)c;
- (UIColor *)darkerColorForColor:(UIColor *)c;

@end
