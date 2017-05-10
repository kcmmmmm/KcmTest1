//
//  ZoomScrollViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 10..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "ZoomScrollViewController.h"
#import "CustomNavigationBar.h"

@interface ZoomScrollViewController ()

@end

@implementation ZoomScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [CustomNavigationBar navigationBarTitleViewController:self withTitle:@"스크롤줌"];
    [CustomNavigationBar drawBackButton:self withAction:@selector(onNaviBackButton)];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 200)];
    [_imgView setBackgroundColor:[UIColor yellowColor]];
    [_imgView setImage:[UIImage imageNamed:@"image1.jpg"]];
    [_imgView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_imgView];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = _imgView.frame;
    [_imgView addSubview:visualEffectView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView setContentInset:UIEdgeInsetsMake(_imgView.frame.origin.y + _imgView.frame.size.height, 0, 0, 0)];
    [self.view addSubview:_tableView];
}

#pragma mark - NavigationBar Action

- (void) onNaviBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
    NSLog(@"dealloc");
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"-scrollView.contentOffset.y => %f", -scrollView.contentOffset.y);
    NSLog(@"_tableView.contentInset.top => %f", _tableView.contentInset.top);
    
    if (-scrollView.contentOffset.y > _tableView.contentInset.top) {
        float scale = 1.0f + fabs(-scrollView.contentOffset.y - _tableView.contentInset.top) / _imgView.frame.size.height;
        scale = MAX(0.0f, scale);
        _imgView.transform = CGAffineTransformMakeScale(scale, scale);
        
        CGRect rect = _imgView.frame;
        rect.origin.y = 65;
        _imgView.frame = rect;
    }
    
}


#pragma mark - UITableViewDelegate

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
