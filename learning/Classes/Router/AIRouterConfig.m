//
//  AIRouterConfig.m
//  learning
//
//  Created by 祥伟 on 2018/6/21.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIRouterConfig.h"
#import <JLRoutes/JLRoutes.h>
#import <objc/runtime.h>

NSString *const AIControllerName              = @"viewController";
NSString *const AITabBarControllerSel         = @"sel";

NSString *const AIControllerNameParams        = @"/:viewController";
NSString *const AIControllerNameParamsTabBar  = @"/tab/:sel";
NSString *const AIControllerNameParamsSchemes = @"/tab/:sel/:viewController";

NSString *const AIControllerNameParamsPresent = @"/present/:viewController";

NSString *const AIControllerPopRoot           = @"root";

@implementation AIRouterConfig

+ (AIRouterConfig *)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)openURL:(NSString *)path{
    [self openURL:path parameters:nil];
}

+ (void)openURL:(NSString *)path parameters:(NSDictionary *)parameters{
    [self sharedManager].parameters = parameters;
    
    if (![path hasPrefix:@"learning:/"]) {
        path = [NSString stringWithFormat:@"learning:/%@",path];
    }
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [[UIApplication sharedApplication] openURL:url];
}

+ (void)closeURL:(NSString *)path{
    [self closeURL:path viewController:nil];
}

+ (void)closeURL:(NSString *)path parameters:(NSDictionary *)parameters{
    [self closeURL:path viewController:nil parameters:parameters];
}

+ (void)closeURL:(NSString *)path viewController:(UIViewController *)viewController{
    [self closeURL:path viewController:viewController parameters:nil];
    
}

+ (void)closeURL:(NSString *)path viewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters{
    [self sharedManager].parameters = parameters;
    
    if (!viewController) {
        viewController = [self currentViewController];
    }
    
    if (viewController.presentingViewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (path == AIControllerPopRoot){
            [viewController.navigationController popToRootViewControllerAnimated:YES];
        }else if (!IsEmpty(path)){
            Class class = NSClassFromString(path);
            for (UIViewController *controller in viewController.navigationController.viewControllers) {
                if ([viewController isMemberOfClass:class]) {
                    [viewController.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [viewController.navigationController popViewControllerAnimated:YES];
        }
    }
}

+ (void)routesConfig{
    [[JLRoutes globalRoutes] addRoutes:@[AIControllerNameParams,AIControllerNameParamsTabBar,AIControllerNameParamsSchemes,AIControllerNameParamsPresent]
                               handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
                    
                                   NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:[self sharedManager].parameters];
                                   [params setValuesForKeysWithDictionary:parameters];
                                   [self routeParameters:params];
                                   
                                   return YES;
    }];
}

+ (void)routeParameters:(NSDictionary *)parameters{
    UIViewController *currentVC = [self currentViewController];
    NSString *routeScheme = parameters[@"JLRoutePattern"];
    
    if (routeScheme == AIControllerNameParams|| routeScheme == AIControllerNameParamsPresent) {
        if ([parameters valueForKey:AIControllerName]) {
            UIViewController *vc = [self checkClass:parameters[AIControllerName]];
            
            if (vc == nil) {
                return ;
            }
            
            [self paramToVC:vc param:parameters];
            [self additionalPropertyListToVC:vc param:parameters];
            
            if (routeScheme == AIControllerNameParams) {
                
                if (currentVC.navigationController == nil) {
                    return;
                }
                [currentVC.navigationController pushViewController:vc animated:YES];
            }else{
                [currentVC presentViewController:vc animated:YES completion:nil];
            }
        }
        
    }else if (routeScheme == AIControllerNameParamsSchemes || routeScheme == AIControllerNameParamsTabBar){
        UITabBarController *tabVC = currentVC.tabBarController;
        
        if (tabVC == nil) {
            return;
        }
        
        NSUInteger selIndex = [parameters[AITabBarControllerSel] integerValue];
        if (tabVC.childViewControllers.count <= selIndex) {
            return;
        }
        
        if (currentVC.navigationController == nil) {
            return;
        }
        
        if (currentVC.navigationController.childViewControllers.count > 1) {
            [currentVC.navigationController popToRootViewControllerAnimated:YES];
        }
        
        tabVC.selectedIndex = selIndex;
        
        if ([parameters valueForKey:AIControllerName]) {
            UIViewController *vc = [self checkClass:parameters[AIControllerName]];
            
            if (vc == nil) {
                return;
            }
            
            [self paramToVC:vc param:parameters];
            [self additionalPropertyListToVC:vc param:parameters];
           
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }
    }
}

+ (UIViewController *)checkClass:(NSString *)className{
    
    Class class = NSClassFromString(className);
    if (!class) {
        return nil;
    }
    return [[class alloc]init];
}

+ (void)paramToVC:(UIViewController *)vc param:(NSDictionary<NSString *,NSString *> *)parameters{
    //runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(vc.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [vc setValue:param forKey:key];
        }
    }
    free(properties);
}

//动态添加属性、父类属性需要单独处理(viewController)
+ (void)additionalPropertyListToVC:(UIViewController *)vc param:(NSDictionary<NSString *,NSString *> *)parameters{
    NSArray *properties = @[@"fd_prefersNavigationBarHidden",@"fd_interactivePopDisabled"];
    [properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *param = parameters[obj];
        if (param != nil) {
            [vc setValue:param forKey:obj];
        }
    }];
}

//获取顶层VC
+ (UIViewController *)currentViewController{
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self topViewController:viewController];
}

//递归方法
+ (UIViewController*)topViewController:(UIViewController *)vc{
    if (vc.presentedViewController) {
        return [self topViewController:vc.presentedViewController];
    }else if ([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController *tmp = (UISplitViewController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.viewControllers.lastObject]:vc;
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *tmp = (UINavigationController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.topViewController]:vc;
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tmp = (UITabBarController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.selectedViewController]:vc;
    }
    return vc;
}

@end
