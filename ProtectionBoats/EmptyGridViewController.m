//
//  EmptyGridViewController.m
//  ProtectionBoats
//
//  Created by Daniel Tucker on 22/03/2016.
//  Copyright © 2016 iV01d. All rights reserved.
//

#import "EmptyGridViewController.h"
#import "GridView.h"

#define ROWS 4
#define COLS 4

@interface EmptyGridViewController ()

@property (nonatomic, assign) CGRect gridFrame;
@property (weak, nonatomic) IBOutlet UISlider *rowsSlider;
@property (weak, nonatomic) IBOutlet UISlider *colsSlider;

@end

@implementation EmptyGridViewController
{
    GridView *grid;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    NSInteger sliderValue;
    sliderValue = lroundf(sender.value);
    [sender setValue:sliderValue animated:YES];
    if ([sender.accessibilityIdentifier isEqualToString:@"rows"])
    {
        [grid setGridRowsTo:sliderValue];
    } else
    {
        [grid setGridColsTo:sliderValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gridFrame = CGRectMake(20, 150, self.view.bounds.size.width - 40, self.view.bounds.size.height - 300);
    grid = [[GridView alloc] initWithNumberOfRows:ROWS andCols:COLS];
    grid.frame = self.gridFrame;
    
    [self.view addSubview:grid];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Using Custom Fonts";
    label.font = [UIFont fontWithName:@"FontAwesome" size:35];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
