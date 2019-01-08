//
//  DeviceModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/3.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

+ (NSArray *)methodList{
    return @[
#if (TARGET_OS_SIMULATOR == 0)
             @"isJailBreak",
#endif
             
             @"wifiName",
             @"wifiMac",
             @"UUID",
             @"IDFA",
             @"name",
             @"model",
             @"systemName",
             @"systemVersion",
             @"getIPAddress:"
             ];
}

+ (NSDictionary *)getDeviceInfo{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    [[self methodList] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(obj);
        if ([UIDevice respondsToSelector:sel]) {
            id value = [UIDevice performSelector:sel withObject:@(YES)];
            if (![value isKindOfClass:[NSString class]]) {
                value = value?@"YES":@"NO";
            }
            
            obj = [obj stringByReplacingOccurrencesOfString:@":" withString:@""];
            [info setValue:value forKey:obj];
        }
        
    }];
    
    return info;
}

@end
