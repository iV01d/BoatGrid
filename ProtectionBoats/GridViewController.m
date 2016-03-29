//
//  GridViewController.m
//  ProtectionBoats
//
//  Created by Daniel Tucker on 21/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import "GridViewController.h"
#import "GridView.h"

#define ROWS 7
#define COLS 7

@interface GridViewController ()

@property (nonatomic, assign) CGRect gridFrame;

@end

@implementation GridViewController
{
    NSMutableArray *boats;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gridFrame = CGRectMake(20, 150, self.view.bounds.size.width - 40, self.view.bounds.size.height - 300);
    GridView *grid = [[GridView alloc] initWithNumberOfRows:ROWS andCols:COLS];
    grid.frame = self.gridFrame;
    
    // Add boats
    for (BoatSquare *b in boats)
    {
        [grid addBoat:b];
    }
    
    [self.view addSubview:grid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addBoatsFromArray:(NSArray *)boatArray
{
    if (boats == nil)
    {
        boats = [[NSMutableArray alloc] init];
    }
    boats = [boatArray mutableCopy];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
