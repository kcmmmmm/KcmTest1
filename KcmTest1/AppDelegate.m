//
//  AppDelegate.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "AppDelegate.h"

NSString* const OPEN_URL_REQUEST = @"OPEN_URL_REQUEST";

@implementation OpenUrlRequest

@end

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate*)instance {
    return (AppDelegate*) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _mainViewCtrl = [[MainViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:_mainViewCtrl];
    [self.window makeKeyAndVisible];
    
    
//    NSManagedObjectContext *context = self.managedObjectContext;
//    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
//    [managedObject setValue:@"2017-04-04" forKey:@"executedate"];
//    NSError *error;
//    [context save:&error];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL ret = YES;
    NSLog(@"handleOpenURL, %@", [url absoluteString]);
    ret = [self handleOpenUrl:url];
    return ret;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    BOOL ret = YES;
    NSLog(@"openURL, %@, %@", [url absoluteString], options);
    ret = [self handleOpenUrl:url];
    return ret;
}

- (BOOL)handleOpenUrl:(NSURL*)url {
    BOOL ret = NO;
    
    NSString* scheme = [url scheme];
    NSString* host = [url host];
    NSString* query = [url query];
    NSLog(@"%@ %@, %@", scheme, host, query);
    
    if ([scheme isEqualToString:@"kcmtest"]) {
        if ([host isEqualToString:@"test"]) {
            
            OpenUrlRequest *our = [[OpenUrlRequest alloc] init];
            our.from = KCMRequestFromToday;
            
            [self addOpenUrlRequest:our];
            
            if (self.launchComplete) {
                [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_URL_REQUEST object:nil];
            } else {
                [AppDelegate instance].mainViewCtrl.hasOpenUrlRequest = YES;
            }
            
            ret = YES;
        }
        else {
            OpenUrlRequest *our = [[OpenUrlRequest alloc] init];
            our.from = KCMRequestFromNone;
            
            [self addOpenUrlRequest:our];
            
            if (self.launchComplete) {
                [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_URL_REQUEST object:nil];
            } else {
                [AppDelegate instance].mainViewCtrl.hasOpenUrlRequest = YES;
            }
            
            ret = YES;
        }
    }
    
    return ret;
}

- (void)addOpenUrlRequest:(OpenUrlRequest*)our {
    @synchronized (self) {
        if (_openUrlRequests == nil)
            _openUrlRequests = [[NSMutableArray alloc] init];
        
        [_openUrlRequests addObject:our];
    }
}

- (OpenUrlRequest*)nextOpenUrlRequest {
    OpenUrlRequest* our = nil;
    @synchronized (self) {
        if ([_openUrlRequests firstObject]) {
            our = [_openUrlRequests firstObject];
            [_openUrlRequests removeObjectAtIndex:0];
        }
    }
    return our;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DBUCoreData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
