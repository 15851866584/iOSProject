//
//  AppDelegate.m
//  learning
//
//  Created by 祥伟 on 2018/6/11.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import <JLRoutes/JLRoutes.h>
#import "AIHomeTabBarController.h"
#import "AIGuidePageView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UMMobClick/MobClick.h>

#ifdef DEBUG
#import "FPSLabel.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [NSThread sleepForTimeInterval:2.0f];

    //主窗口、根控制器
    [self setRootWindow];
    
    //IOS11适配
    [self configScrollViewAdapt4IOS11];
    
    //防止多个按钮同时触发
    [[UIButton appearance] setExclusiveTouch:YES];
    
    //路由
    [AIRouterConfig routesConfig];
    

    //引导页
    [self configGuidePage];
    
    //友盟统计
    [self UMConfig];
#ifdef DEBUG
    [self.window addSubview:[FPSLabel new]];
#endif

    
    return YES;
}

- (void)setRootWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    AIHomeTabBarController *tabBar = [[AIHomeTabBarController alloc]init];
    [self.window setRootViewController:tabBar];
    [self.window makeKeyAndVisible];
    
    // nav.tabbar阴影去除
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTranslucent:NO];
}


- (void)configScrollViewAdapt4IOS11{
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [WKWebView appearance].scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }

}

- (void)configGuidePage{

    if (IsEmpty([AITools readUUID])) {
        [AITools saveUUID:DEVICEUUID];
        AIGuidePageView *guidePage = [[AIGuidePageView alloc]initWithFrame:self.window.bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
    }
    
}


- (void)UMConfig{
    UMConfigInstance.appKey = @"5b87b06ef29d980a8900000e";
    //一般是这样写，用于友盟后台的渠道统计，当然苹果也不会有其他渠道，写死就好
    UMConfigInstance.channelId = @"App Store";
    //上传模式，这种为最小间隔发送90S，也可按照要求选择其他上传模式。也可不设置，在友盟后台修改。
    UMConfigInstance.ePolicy = SEND_INTERVAL;
    [MobClick setAppVersion:APPVERSION];//进行分版本统
    
#ifdef DEBUG
    [MobClick setLogEnabled:NO];
#endif

    [MobClick startWithConfigure:UMConfigInstance];//开启SDK
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [JLRoutes routeURL:url];
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


@end
