//
//  UIDevice+tool.h
//  learning
//
//  Created by 祥伟 on 2019/1/2.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (tool)

//是否越狱
+ (BOOL)isJailBreak;

//wifiName
+ (NSString *)wifiName;

//wifiMac
+ (NSString *)wifiMac;

+ (NSString *)UUID;

+ (NSString *)IDFA;

+ (NSString *)name;

+ (NSString *)model;

+ (float)batteryLevel;

+ (NSString *)systemName;

+ (NSString *)systemVersion;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString *)getMacAddress;
@end

NS_ASSUME_NONNULL_END
