//
//  AppDelegate.h
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

typedef NS_ENUM(NSInteger, KCMRequestFrom) {
    KCMRequestFromNone      = 0,
    KCMRequestFromToday     = 1,
};

extern NSString* const OPEN_URL_REQUEST;

@interface OpenUrlRequest : NSObject

@property (nonatomic) KCMRequestFrom from; 

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray* _openUrlRequests;
   
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) MainViewController* mainViewCtrl;

@property (nonatomic) BOOL launchComplete; // 앱 구동 완료 여부

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (AppDelegate*)instance;
- (OpenUrlRequest*)nextOpenUrlRequest;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

