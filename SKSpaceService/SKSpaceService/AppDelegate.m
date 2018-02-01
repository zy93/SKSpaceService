//
//  AppDelegate.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/23.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "AppDelegate.h"
#import "WOTBaseNavigationController.h"
#import "WOTUserSingleton.h"
#import "LoginViewController.h"
#import "SKSalesMainVC.h"
#import "SKRepairVC.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WOTUserSingleton shared].firstLoad = YES;
    [self loadViewController];
    [WOTUserSingleton shared].firstLoad = NO;
    
    //注册推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"66c0aa6d5aad93cbf657ac58" channel:@"Test" apsForProduction:NO];
    [JPUSHService setBadge:0];
    
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SKSpaceService"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void)loadViewController
{
    if ([WOTUserSingleton shared].isLogin) {
        //第一次启动
        if ([WOTUserSingleton shared].isFirstLoad) {
            //读取上次显示页面
            if ([[WOTUserSingleton shared].userInfo.currentStatus isEqualToString:@"销控管理"]) {
                [WOTUserSingleton shared].userInfo.currentStatus = @"销控管理";
                [self loadViewControllerWithName:@"SKSalesMainVC"];
            }
            else if ([[WOTUserSingleton shared].userInfo.currentStatus isEqualToString:@"报修管理"]) {
                [WOTUserSingleton shared].userInfo.currentStatus = @"报修管理";
                [self loadViewControllerWithName:@"SKRepairVC"];
            }
        }
        //登录后
       else if (strIsEmpty([WOTUserSingleton shared].userInfo.currentStatus) ||
           [WOTUserSingleton shared].firstLoad == YES) {
            //是否有
            if ([[WOTUserSingleton shared].userInfo.jurisdiction containsString:@"销控管理"]) {
                [WOTUserSingleton shared].userInfo.currentStatus = @"销控管理";
                [self loadViewControllerWithName:@"SKSalesMainVC"];
            }
            else if ([[WOTUserSingleton shared].userInfo.jurisdiction containsString:@"报修管理"]) {
                [WOTUserSingleton shared].userInfo.currentStatus = @"报修管理";
                [self loadViewControllerWithName:@"SKRepairVC"];
            }
            else {
                [MBProgressHUDUtil showMessage:@"没有其他权限！" toView:self.window.rootViewController.view];
            }
        }
        //否则：目前是销控权限 切换到 报修管理权限
        else if ([[WOTUserSingleton shared].userInfo.jurisdiction containsString:@"报修管理"] &&
                 [[WOTUserSingleton shared].userInfo.currentStatus isEqualToString:@"销控管理"]
                 ) {
            [WOTUserSingleton shared].userInfo.currentStatus = @"报修管理";
            [self loadViewControllerWithName:@"SKRepairVC"];
        }
        //否则：目前是 报修管理权限 切换到 销控权限
        else if ([[WOTUserSingleton shared].userInfo.jurisdiction containsString:@"销控管理"] &&
                 [[WOTUserSingleton shared].userInfo.currentStatus isEqualToString:@"报修管理"]) {
            [WOTUserSingleton shared].userInfo.currentStatus = @"销控管理";
            [self loadViewControllerWithName:@"SKSalesMainVC"];
        }
        else {
            [MBProgressHUDUtil showMessage:@"没有其他权限！" toView:self.window.rootViewController.view];
        }
    }
    else {
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
}

-(void)loadViewControllerWithName:(NSString *)vcName
{
    Class class = NSClassFromString(vcName);
    WOTBaseNavigationController *nav = [[WOTBaseNavigationController alloc] initWithRootViewController:[[class alloc] init]];
    self.window.rootViewController = nav;
}

#pragma mark - JPush delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
