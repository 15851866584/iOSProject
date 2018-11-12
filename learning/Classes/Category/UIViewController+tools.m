//
//  UIViewController+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/14.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIViewController+tools.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation UIViewController (tools)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(viewWillAppear:) withSwizzleMethod:@selector(ai_viewWillAppear:)];
        [self swizzleInstanceMethod:@selector(viewWillDisappear:) withSwizzleMethod:@selector(ai_viewWillDisappear:)];
    });
}

- (void)ai_viewWillAppear:(BOOL)animated{
    [self ai_viewWillAppear:animated];

    if (self.navigationController != nil) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
            self.navigationController.interactivePopGestureRecognizer.enabled = !self.isCloseRightSlide;
        }
        
        
        if (self.navigationBarControl == NavigationBarHide || self.navigationBarControl == NavigationBarHideShow) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else if (self.navigationBarControl == NavigationBarShow || self.navigationBarControl == NavigationBarShowHide){
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }

}

- (void)ai_viewWillDisappear:(BOOL)animated{
    [self ai_viewWillDisappear:animated];
    
    if (self.navigationController != nil) {
        if (self.navigationBarControl == NavigationBarHide || self.navigationBarControl == NavigationBarShowHide) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else if (self.navigationBarControl == NavigationBarShow || self.navigationBarControl == NavigationBarHideShow){
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }

}

//----------------------------------------------
- (NavigationBarControl)navigationBarControl{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setNavigationBarControl:(NavigationBarControl)navigationBarControl{
    objc_setAssociatedObject(self, @selector(navigationBarControl), @(navigationBarControl), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//----------------------------------------------
- (BOOL)isCloseRightSlide{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setIsCloseRightSlide:(BOOL)isCloseRightSlide{
    objc_setAssociatedObject(self, @selector(isCloseRightSlide), @(isCloseRightSlide), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
