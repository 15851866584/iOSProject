//
//  AIBaseTabBarController.h
//  learning
//
//  Created by 祥伟 on 2018/8/3.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIBaseTabBarController : UITabBarController

- (void)setUpViewControllers;

- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                       tabBarImageName:(NSString *)imageName;

/*
 *  底部item布局
 *
 *  @param class      Nav
 *  @param rootClass  VC
 *  @param name       icon_name
 *  @param size       12
 *  @param color      color
 *  @param selColor   selColor
 *  @param imageName  IMG
 *
 */
- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                                  size:(UIFont *)size
                                 color:(UIColor *)color
                              selColor:(UIColor *)selColor
                       tabBarImageName:(NSString *)imageName;
@end
