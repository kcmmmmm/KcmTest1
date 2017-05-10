//
//  PageViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 6..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setDelegate:self];
    [self setDataSource:self];
    
    _viewControllers = [NSMutableArray new];
    for (NSInteger i = 0; i < 5; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.frame = self.view.frame;
        vc.view.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [[UILabel alloc] initWithFrame:vc.view.frame];
        lb.text = [NSString stringWithFormat:@"페이지뷰 컨트롤러 %ld", i];
        lb.textColor = [UIColor blueColor];
        lb.textAlignment = NSTextAlignmentCenter;
        [vc.view addSubview:lb];
        [_viewControllers addObject:vc];
    }
    
    [self setViewControllers:@[[_viewControllers objectAtIndex:0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      
                  }];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_viewControllers indexOfObject:viewController];
    index--;
    
    if (index < 0) {
        return nil;
    }
    else {
        return [_viewControllers objectAtIndex:index];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [_viewControllers indexOfObject:viewController];
    index++;
    
    if (index == [_viewControllers count]) {
        return nil;
    }
    else {
        return [_viewControllers objectAtIndex:index];
    }
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
