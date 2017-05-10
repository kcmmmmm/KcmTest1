//
//  DynamicMenuViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "DynamicMenuViewController.h"

@interface DynamicMenuViewController ()

@end

@implementation DynamicMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    const int menuH = 250;
    _upperMenu = [[UIView alloc] initWithFrame:CGRectMake(0, -menuH, 300, menuH)];
    [_upperMenu.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [_upperMenu.layer setCornerRadius:5.0];
    [_upperMenu.layer setBorderWidth:3.0];
    [self.view addSubview:_upperMenu];
    
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, menuH)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [_upperMenu addSubview:_tableView];
    
    _toggleMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30, 60, 30)];
    [_toggleMenu setBackgroundColor:[UIColor grayColor]];
    [_toggleMenu setTitle:@"열기" forState:UIControlStateNormal];
    [_toggleMenu setTitle:@"닫기" forState:UIControlStateSelected];
    [_toggleMenu addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_toggleMenu];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] init];
    _collision = [[UICollisionBehavior alloc] init];
    [_collision addBoundaryWithIdentifier:@"_upperMenuBottom" fromPoint:CGPointMake(0, menuH+20) toPoint:CGPointMake(320, menuH+20)];
    
    [_animator addBehavior:_gravity];
    [_animator addBehavior:_collision];
}

- (void)toggleMenu {
    const int menuH = 250;
    if (_toggleMenu.isSelected) {
        //닫기
        [_gravity removeItem:_upperMenu];
        [_collision removeItem:_upperMenu];
        [UIView animateWithDuration:0.6 animations:^{
            [_upperMenu setFrame:CGRectMake(10, -menuH, 300, menuH)];
        }];
    }
    else {
        //열기
        [_gravity addItem:_upperMenu];
        [_collision addItem:_upperMenu];
    }
    [_toggleMenu setSelected:!_toggleMenu.selected];
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    NSString *item = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = item;
    
    return cell;
}

@end
