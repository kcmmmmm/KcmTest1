//
//  MainViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *_arrMenu;
}

@property (weak, nonatomic) IBOutlet UIView *dragView;
@property (weak, nonatomic) IBOutlet UIImageView *imgBarcode;
@property (weak, nonatomic) IBOutlet UIImageView *imgQRcode;
@property (weak, nonatomic) IBOutlet UILabel *lbCounty;
@property (weak, nonatomic) IBOutlet UILabel *lbTc;
@property (weak, nonatomic) IBOutlet UILabel *lbYesterdayTmax;
@property (weak, nonatomic) IBOutlet UILabel *lbYesterdayTmin;
@property (weak, nonatomic) IBOutlet UILabel *lbTodayTmax;
@property (weak, nonatomic) IBOutlet UILabel *lbTodayTmin;
@property (weak, nonatomic) IBOutlet UILabel *lbTomorrowTmax;
@property (weak, nonatomic) IBOutlet UILabel *lbTomorrowTmin;
@property (weak, nonatomic) IBOutlet UILabel *lbDaTomorrowTmax;
@property (weak, nonatomic) IBOutlet UILabel *lbDaTomorrowTmin;

@property (weak, nonatomic) IBOutlet UICollectionView *mainCv;


@property (nonatomic) BOOL hasOpenUrlRequest;                   //openUrlRequest 실행 여부

@end
