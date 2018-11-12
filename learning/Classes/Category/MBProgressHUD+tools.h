//
//  MBProgressHUD+tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/15.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "MBProgressHUD.h"


typedef NS_ENUM(NSInteger, HUDLoadingType) {
    
    HUDLoadingIndicator,//菊花
    HUDLoadingAround,//环形

};

@interface MBProgressHUD (tools)

@property (assign) HUDLoadingType loadingType;

/*
 *   textcolor = white
 *   textfont  = 14
 *   delay     = 1s
 */

+ (MBProgressHUD *)showHUD:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (MBProgressHUD *)showHUD:(NSString *)text images:(NSArray *)images view:(UIView *)view;

+ (MBProgressHUD *)showHUD:(NSString *)text loadingType:(HUDLoadingType)type view:(UIView *)view;

+ (void)hide:(UIView *)view;

- (void)hide;

- (void)hideDelay:(NSTimeInterval)delay;

@end
