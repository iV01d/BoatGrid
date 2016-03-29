//
//  ProtectionBoatsTests.m
//  ProtectionBoatsTests
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BoatSquare.h"

@interface ProtectionBoatsTests : XCTestCase

@end

@implementation ProtectionBoatsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testPrintSquare
{
    BoatSquare *test = [[BoatSquare alloc] init];
    NSLog(@"%@", test);
}

-(void)testSetX
{
    BoatSquare *test = [[BoatSquare alloc] init];
    test.x = 4;
}

-(void)testCalculation
{
    BoatSquare *test = [[BoatSquare alloc] initWithX:5 andY:5];
    BoatSquare *second = [[BoatSquare alloc] initWithX:5 andY:5];
    
    NSInteger result = [test calculateDistanceToSquare:second];
    
    NSLog(@"Distance: %ld", result);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
