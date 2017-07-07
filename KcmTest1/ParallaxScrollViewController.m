//
//  ParallaxScrollViewController.m
//  KcmTest1
//
//  Created by wimz-kcm on 2017. 7. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "ParallaxScrollViewController.h"
#import "CustomNavigationBar.h"

@interface ParallaxScrollViewController ()

@end

@implementation ParallaxScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [CustomNavigationBar navigationBarTitleViewController:self withTitle:@"스크롤줌"];
    [CustomNavigationBar drawBackButton:self withAction:@selector(onNaviBackButton)];
    
    
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [_imgView setBackgroundColor:[UIColor yellowColor]];
    [_imgView setImage:[UIImage imageNamed:@"image1.jpg"]];
    [_imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    [_headerScrollView addSubview:_imgView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _headerScrollView;
}

#pragma mark - NavigationBar Action

- (void) onNaviBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"-scrollView.contentOffset.y => %f", -scrollView.contentOffset.y);
    NSLog(@"_tableView.contentInset.top => %f", _tableView.contentInset.top);
    
    CGRect frame = _imgView.frame;
    
    if (scrollView.contentOffset.y > 0)
    {
        _headerScrollView.clipsToBounds = YES;
        
        frame.origin.y = MAX(scrollView.contentOffset.y * 0.5f, 0);
        _imgView.frame = frame;
        _imgView.clipsToBounds = YES;
        
//        [_headerScrollView setContentOffset:CGPointMake(0, MAX(scrollView.contentOffset.y * 0.5f, 0)) animated:NO];
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, _headerScrollView.frame.size.width, _headerScrollView.frame.size.height);
        delta = fabs(MIN(0.0f, scrollView.contentOffset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _headerScrollView.frame = rect;
        _imgView.clipsToBounds = NO;
        
        _headerScrollView.clipsToBounds = NO;
    }
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.contentView.frame = CGRectMake(0, cell.frame.size.height, cell.frame.size.width, cell.frame.size.height);
    
    [UIView animateWithDuration:1.0f animations:^{
        cell.contentView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    NSString *item = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = item;
    //    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
