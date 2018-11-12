//
//  UIViewController+tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/14.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NavigationBarControl) {
    NavigationBarDefult = 0,
    NavigationBarShow,
    NavigationBarHide,
    NavigationBarShowHide,
    NavigationBarHideShow
};

@interface UIViewController (tools)

@property (nonatomic, assign) NavigationBarControl navigationBarControl;

/* default set open */
@property (nonatomic, assign) BOOL isCloseRightSlide;


@end
