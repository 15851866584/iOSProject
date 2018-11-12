//
//  MBProgressHUD+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/15.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "MBProgressHUD+tools.h"

#define AI_Default_Size  AI_SYSTEM_Size(14.0)
#define AI_Default_Color AI_RGB255

@implementation MBProgressHUD (tools)

@dynamic loadingType;

+ (MBProgressHUD *)showHUD:(UIView *)view{
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.animationType = MBProgressHUDAnimationZoom;
    
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7];
    HUD.removeFromSuperViewOnHide = YES;
    return HUD;
}

+ (MBProgressHUD *)showHUD:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    
    MBProgressHUD *HUD = [self showHUD:view];
    HUD.mode = MBProgressHUDModeCustomView;

    if (icon && IMG(icon)) {
        HUD.customView = [[UIImageView alloc] initWithImage:IMG(icon)];
    }
    
    if (text) {
       
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = AI_Default_Size;
        HUD.detailsLabel.textColor = AI_Default_Color;
    }

    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}


+ (MBProgressHUD *)showHUD:(NSString *)text images:(NSArray *)images view:(UIView *)view{
    
    MBProgressHUD *HUD = [self showHUD:view];
    HUD.mode = MBProgressHUDModeCustomView;
    
    if (images.count) {
        NSMutableArray *animationImages = [NSMutableArray array];
        for (id obj in images) {
            if ([obj isKindOfClass:[NSString class]]) {
                [animationImages addObject:IMG(obj)];
            }else if ([obj isKindOfClass:[UIImage class]]){
                [animationImages addObject:obj];
            }
        }
        UIImageView *animateGifView = [[UIImageView alloc]init];
        animateGifView.animationImages = animationImages;
        animateGifView.animationDuration = 1.0;
        animateGifView.animationRepeatCount = 0;
        
        [animateGifView startAnimating];
        HUD.customView = animateGifView;
    }
    
    if (text) {
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = AI_Default_Size;
        HUD.detailsLabel.textColor = AI_Default_Color;
    }
    
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (MBProgressHUD *)showHUD:(NSString *)text loadingType:(HUDLoadingType)type view:(UIView *)view{
    
    MBProgressHUD *HUD = [self showHUD:view];
    
    if (type == HUDLoadingIndicator) {
        
        HUD.mode = MBProgressHUDModeIndeterminate;
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
    }else if (type == HUDLoadingAround){
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.minSize = CGSizeMake(100, 100);

        UIImageView *circleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55.0f, 55.0f)];
        circleView.image = [UIImage createImageWithColor:[UIColor clearColor] size:circleView.size];
        [circleView.layer drawCircleRotate];
        HUD.customView = circleView;
    }
    
    if (text) {
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = AI_Default_Size;
        HUD.detailsLabel.textColor = AI_Default_Color;
    }
    
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (void)hide:(UIView *)view{

    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subView;
            [hud hideAnimated:YES];
        }
    }
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subView;
            [hud hideAnimated:YES];
        }
    }
}

- (void)hide{
    [self hideAnimated:YES];
}

- (void)hideDelay:(NSTimeInterval)delay{
    [self hideAnimated:YES afterDelay:delay];
}
@end
