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
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [_headerView addSubview:_headerScrollView];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [_imgView setImage:[UIImage imageNamed:@"image1.jpg"]];
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_imgView setContentMode:UIViewContentModeScaleAspectFill];
    [_headerScrollView addSubview:_imgView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _headerView;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _beginOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame = _headerScrollView.frame;
    
    if (scrollView.contentOffset.y > 0)
    {
        frame.origin.y = MAX(scrollView.contentOffset.y * 0.5f, 0);
        _headerScrollView.frame = frame;
        _headerView.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height);
        delta = fabs(MIN(0.0f, scrollView.contentOffset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _headerScrollView.frame = rect;
        _headerView.clipsToBounds = NO;
    }
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_beginOffsetY < tableView.contentOffset.y) {
        cell.contentView.frame = CGRectMake(0, cell.frame.size.height, cell.frame.size.width, cell.frame.size.height);
        
        [UIView animateWithDuration:0.5f animations:^{
            cell.contentView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        }];
    }
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
    
    return cell;
}

@end
