//
//  MainViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "MenuManager.h"
#import "CustomAlertView.h"
#import <CoreImage/CoreImage.h>
#import "InterfaceWeather.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"test git commit");
    
    [self.mainCv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MENU_CELL"];
    _arrMenu = makeIndexListFromMenus([MenuManager manager].mainMenu);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processOpenUrlRequest:) name:OPEN_URL_REQUEST object:nil];
    
    [AppDelegate instance].launchComplete = YES;
    
//    int multiplier = 7;
//    
//    int (^myBlock)(int) = ^(int num) {
//        return  num * multiplier;
//    };
    
//    NSLog(@"result myBlock(10) => %d", myBlock(10));
    
//    [CustomAlertView showMessagePopup:@"알림" handler:^(NSInteger btnIndex) {
//       [CustomAlertView showMessagePopup:@"알림2" cancelButtonTitle:AlertNo otherButtonTitle:AlertYes handler:^(NSInteger btnIndex) {
//           if (btnIndex == 1) {
//               [CustomAlertView showMessagePopup:@"알림3" titleImage:nil cancelButtonTitle:AlertCancel otherButtonTitle:AlertConfirm otherButtonTitle2:@"싫어요" handler:^(NSInteger btnIndex) {
//                   
//               }];
//           }
//       }];
//    }];
    
//    [self createBarcode];
//    [self createQRcode];
    
//    InterfaceWeather *weather = [InterfaceWeather instance];    
//    [weather doMinutelyWeather:[ResMinutelyWeather class] success:^(ResMinutelyWeather *res) {
//        MinutelyInfo *mInfo = res.weather.minutely.firstObject;
//        _lbTc.text = mInfo.temperature.tc;
//        _lbTmax.text = mInfo.temperature.tmax;
//        _lbTmin.text = mInfo.temperature.tmin;
//    } failure:^(NSError *error) {
//        
//    }];
    
//    [weather doStationInfo:[ResStation class] success:^(ResStation *res) {
//        NSLog(@"doStationInfo => %@", res);
//        
//        StationInfo *sInfo = res.weather.station.firstObject;
//        
//        [weather doSummaryWeather:[ResSummaryWeather class]
//                              lat:sInfo.latitude
//                              lon:sInfo.longitude
//                            stnId:sInfo.id
//                          success:^(ResSummaryWeather *res) {
//                              NSLog(@"doSummaryWeather => %@", res);
//                              SummaryInfo *sInfo = res.weather.summary.firstObject;
//                              
//                              GridInfo *gridInfo = sInfo.grid;
//                              _lbCounty.text = gridInfo.county;
//                              
//                              DayInfo *yesterDayInfo = sInfo.yesterday;
//                              DayInfo *toDayInfo = sInfo.today;
//                              DayInfo *tomorrowInfo = sInfo.tomorrow;
//                              DayInfo *daTomorrowInfo = sInfo.dayAfterTomorrow;
//                              
//                              _lbYesterdayTmax.text = [self demicalOnePoint:yesterDayInfo.temperature.tmax];
//                              _lbYesterdayTmin.text = [self demicalOnePoint:yesterDayInfo.temperature.tmin];
//                              _lbTodayTmax.text = [self demicalOnePoint:toDayInfo.temperature.tmax];
//                              _lbTodayTmin.text = [self demicalOnePoint:toDayInfo.temperature.tmin];
//                              _lbTomorrowTmax.text = [self demicalOnePoint:tomorrowInfo.temperature.tmax];
//                              _lbTomorrowTmin.text = [self demicalOnePoint:tomorrowInfo.temperature.tmin];
//                              _lbDaTomorrowTmax.text = [self demicalOnePoint:daTomorrowInfo.temperature.tmax];
//                              _lbDaTomorrowTmin.text = [self demicalOnePoint:daTomorrowInfo.temperature.tmin];
//                              
//                          } failure:^(NSError *error) {
//            
//                          }];
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
//    [self perfectNumber:3000];
    
    
//    NSMutableArray *resultArr = [NSMutableArray new];
//    long num = 600851475143;
//    long i, x;
//    for (i = 2; i < num; i++)
//    {
//        if (num % i == 0)
//        {
//            [resultArr addObject:[NSNumber numberWithLong:i]];
//            num = num / i;
//            i = 1;
//        }
//    }
//    
//    x = num;
//    i = 0;
//    
//    while (600851475143 != x) {
//        NSLog(@"%ld", [[resultArr objectAtIndex:i] longValue]);
//        x = x * [[resultArr objectAtIndex:i] longValue];
//        i++;
//    }
//    
//    NSLog(@"num => %ld", num);
    
//    //소인수분해 소인수 중 가장 큰 수
//    int i = 2;
//    long j = 600851475143;
//    
//    while (j != i) {
//        if (j % i == 0) {
//            j = j / i;
//        }
//        else {
//            i++;
//        }
//    }
//    NSLog(@"%ld", j);
    
//    NSInteger result = 0;
//    for (int i = 1000; i > 100; i--)
//    {
//    
//        for (int j = 1000; j > 100; j--)
//        {
//            NSString *reverseNum = [NSString string];
//            NSString *num = [NSString stringWithFormat:@"%d", (i * j)];
//            NSInteger index = [num length];
//            
//            while (index > 0)
//            {
//                index--;
//                reverseNum = [reverseNum stringByAppendingString:[num substringWithRange:NSMakeRange(index, 1)]];
//            }
//            
//            if ([reverseNum isEqualToString:num])
//            {
//                
//                if (result < [num integerValue]) {
//                    result = [num integerValue];
//                }
//                break;
//            }
//        }
//    }
//    
//    NSLog(@"num ==> %ld", result);
  
    // 1 ~ 20 사이의 어떤 수로도 나누어 떨어지는 가장 작은 수
//    int num = 21;
//    for (int i = 1; i < 21; i++) {
//        
//        if (num % i  == 0) {
//            if (i == 20) {
//                NSLog(@"num => %d", num);
//                return;
//            }
//        }
//        else {
//            num++;
//            i = 1;
//        }
//        
//    }
    
//    int sum1 = 0;
//    int sum2 = 0;
//    
//    for (int i = 1; i < 101; i++)
//    {
//        sum1 += i;
//        sum2 += i * i;
//    }
//    
//    sum1 = sum1 * sum1;
//    NSLog(@"%d", sum1 - sum2);
    
    int index = 0;
    int k = 3;
    for (int i = 2; i < k; i++) {
        
        for (int j = 1; j <= i; j++) {
            
            if (i / j == 1 && i / j == i) {
                index++;
            }
            
        }

    }
}

#pragma mark - 완전수 구하기

- (void)perfectNumber:(int)num {
  
    NSString *result = [NSString stringWithFormat:@"1"];
    
    int i, j = 1;
    for (i = 1; i < num + 1; i++) {
       
        int sum = 0;
        for (j = 1; j < i; j++) {
            if (i % j == 0) {
                sum += j;
            }
        }
        
        if (sum == i) {
            result = [result stringByAppendingString:[NSString stringWithFormat:@", %d", sum]];
        }
    }
    
    NSLog(@"input Number => %d perfectNumber => %@", num, result);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_hasOpenUrlRequest) {
        [CustomAlertView showMessagePopup:@"_hasOpenUrlRequest" handler:nil];
        _hasOpenUrlRequest = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_URL_REQUEST object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)demicalOnePoint:(NSString *)num {
    
    NSString *onePoint = [NSString stringWithFormat:@"%.1f", [num floatValue]];
    
    return onePoint;
}

- (void)openMenuWithID:(MenuID)menuID {
    
    MenuInfo *menuInfo = [[MenuManager manager] menuWithID:menuID];
    if (menuInfo) {
        Class cls = menuInfo.menuClass;
        if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [[cls alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

            // modal
//            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
//            navController.transitioningDelegate = self;
//            [self presentViewController:navController animated:YES completion:nil];
        }
        else {
            NSLog(@"%@ cls error!", NSStringFromSelector(_cmd));
        }
    }
    else {
        NSLog(@"%@ error!", NSStringFromSelector(_cmd));
    }
    
}

- (IBAction)startBlink:(id)sender {
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionAutoreverse animations:^{
        self.lbCounty.alpha = 0;
    } completion:^(BOOL finished) {
        self.lbCounty.alpha = 1;
    }];
}

- (void)createBarcode {
    
    NSArray *ary = [CIFilter filterNamesInCategory:kCICategoryGenerator];
    NSLog(@"%@", ary);
    
    NSData* dataBarcode = [@"1234567890" dataUsingEncoding:NSASCIIStringEncoding];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [ciFilter setValue:dataBarcode forKey:@"inputMessage"];
    CIImage *ciImage = [ciFilter outputImage];
    UIImage *img = [UIImage imageWithCIImage:ciImage];
    
    _imgBarcode.image = img;
}

- (void)createQRcode {
    
    NSArray *ary = [CIFilter filterNamesInCategory:kCICategoryGenerator];
    NSLog(@"%@", ary);
    
    NSData* dataBarcode = [@"1234567890" dataUsingEncoding:NSASCIIStringEncoding];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [ciFilter setValue:dataBarcode forKey:@"inputMessage"];
    CIImage *ciImage = [ciFilter outputImage];
    UIImage *img = [UIImage imageWithCIImage:ciImage];
    
    _imgQRcode.image = img;
}


- (void)processOpenUrlRequest:(NSNotification *)notification {
    OpenUrlRequest *our = [[AppDelegate instance] nextOpenUrlRequest];
    
    if (our) {
        if (our.from == KCMRequestFromToday) {
            NSLog(@"KCMRequestFromToday");
            [CustomAlertView showMessagePopup:@"KCMRequestFromToday" handler:nil];
        } else {
            NSLog(@"KCMRequestFromNone");
            [CustomAlertView showMessagePopup:@"KCMRequestFromNone" handler:nil];
        }
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_arrMenu count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MENU_CELL" forIndexPath:indexPath];
    
    NSInteger menuId = [_arrMenu[indexPath.item] integerValue];
    MenuInfo *menuInfo = [[MenuManager manager] menuWithID:menuId];
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:cell.frame];
    lbTitle.backgroundColor = [UIColor grayColor];
    lbTitle.numberOfLines = 0;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont systemFontOfSize:13.0];
    lbTitle.text = menuInfo.menuTitle;
    cell.backgroundView = lbTitle;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger menuId = [_arrMenu[indexPath.item] integerValue];
    [self openMenuWithID:menuId];
}

@end
