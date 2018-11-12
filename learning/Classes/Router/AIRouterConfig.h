//
//  AIRouterConfig.h
//  learning
//
//  Created by 祥伟 on 2018/6/21.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const AIControllerName;
FOUNDATION_EXTERN NSString *const AITabBarControllerSel;

FOUNDATION_EXTERN NSString *const AIControllerNameParams;
FOUNDATION_EXTERN NSString *const AIControllerNameParamsTabBar;
FOUNDATION_EXTERN NSString *const AIControllerNameParamsSchemes;
FOUNDATION_EXTERN NSString *const AIControllerNameParamsPresent;

FOUNDATION_EXTERN NSString *const AIControllerPopRoot;

#define OpenURL(path)\
[AIRouterConfig openURL:path]\

#define OpenURLp(path,params)\
[AIRouterConfig openURL:path parameters:params]\

#define CloseURL(path)\
[AIRouterConfig closeURL:path]\

#define CloseURLp(path,params)\
[AIRouterConfig closeURL:path parameters:params]\

#define CloseVCURL(path,vc)\
[AIRouterConfig closeURL:path viewController:vc]\

#define CloseVCURLp(path,vc,params)\
[AIRouterConfig closeURL:path viewController:vc parameters:params]\

@interface AIRouterConfig : NSObject
@property (nonatomic, copy) NSDictionary *parameters;//传参
+ (AIRouterConfig *)sharedManager;

//页面跳转配置
+ (void)routesConfig;

//页面跳转
+ (void)openURL:(NSString *)path;
+ (void)openURL:(NSString *)path parameters:(NSDictionary *)parameters;
+ (void)closeURL:(NSString *)path;
+ (void)closeURL:(NSString *)path parameters:(NSDictionary *)parameters;
+ (void)closeURL:(NSString *)path viewController:(UIViewController *)viewController;
+ (void)closeURL:(NSString *)path viewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters;

#define AI_getCurrentViewController [AIRouterConfig currentViewController]
+ (UIViewController *)currentViewController;
@end
