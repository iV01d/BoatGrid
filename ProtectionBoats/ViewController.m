//
//  ViewController.m
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import "ViewController.h"
#import "GridViewController.h"
#import "BoatSquare.h"
#import "EmptyGridViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *createdBoats;
@property (weak, nonatomic) IBOutlet UITextField *firstShipX;
@property (weak, nonatomic) IBOutlet UITextField *firstShipY;
@property (weak, nonatomic) IBOutlet UITextField *secondShipX;
@property (weak, nonatomic) IBOutlet UITextField *secondShipY;
@property (weak, nonatomic) IBOutlet UITextField *thirdShipX;
@property (weak, nonatomic) IBOutlet UITextField *thirdShipY;

@end

@implementation ViewController

@synthesize firstShipX, firstShipY, secondShipX, secondShipY, thirdShipX, thirdShipY;

-(NSMutableArray *) createdBoats
{
    if (_createdBoats == nil)
    {
        _createdBoats = [[NSMutableArray alloc] init];
        NSLog(@"Making Array!");
    }
    return _createdBoats;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Grid"])
    {
        if ([segue.destinationViewController isKindOfClass:[GridViewController class]])
        {
            [self createBoats];
            NSLog(@"Array Of Boats: %@", self.createdBoats);
            GridViewController *gvc = (GridViewController *)segue.destinationViewController;
            [gvc addBoatsFromArray:self.createdBoats];
        }
    }
    else if ([segue.identifier isEqualToString:@"EmptyGrid"])
    {
        if ([segue.destinationViewController isKindOfClass:[EmptyGridViewController class]])
        {
            
        }
    }
}

-(void) createBoatAtX:(NSInteger)x andY:(NSInteger)y
{
    BoatSquare *createdBoat = [[BoatSquare alloc] initWithX:x andY:y];
    [createdBoat setSquareToBoat];
    [self.createdBoats addObject:createdBoat];
}

#pragma mark - Private

-(void) createBoats
{
    if (self.firstShipX.text.length > 0 && self.firstShipY.text.length > 0)
        [self createBoatAtX:[self.firstShipX.text floatValue] andY:[self.firstShipY.text floatValue]];
    
    if (self.secondShipX.text.length > 0 && self.secondShipY.text.length > 0)
        [self createBoatAtX:[self.secondShipX.text floatValue] andY:[self.secondShipY.text floatValue]];
    
    if (self.thirdShipX.text.length > 0 && self.thirdShipY.text.length > 0)
        [self createBoatAtX:[self.thirdShipX.text floatValue] andY:[self.thirdShipY.text floatValue]];
}

#pragma mark - View Methods

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Clearing Boat Array
    self.createdBoats = nil;
    // Clear TextFields
    self.firstShipX.text = @"";
    self.firstShipY.text = @"";
    self.secondShipX.text = @"";
    self.secondShipY.text = @"";
    self.thirdShipX.text = @"";
    self.thirdShipY.text = @"";
}

@end
