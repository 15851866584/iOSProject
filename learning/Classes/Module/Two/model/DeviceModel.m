//
//  DeviceModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/3.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

//使用performSelector返回值不支持基础类型，可以使用NSInvocation
+ (NSArray *)methodList{
    return @[

             @"wifiName",
             @"wifiMac",
             @"UUID",
             @"IDFA",
             @"name",
             @"model",
             @"systemName",
             @"systemVersion",
             @"getIPAddress:",
             
             ];
}

+ (NSDictionary *)getDeviceInfo{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    [[self methodList] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(obj);
        if ([UIDevice respondsToSelector:sel]) {
            id value = [UIDevice performSelector:sel];
            
            obj = [obj stringByReplacingOccurrencesOfString:@":" withString:@""];
            [info setValue:value forKey:obj];
        }
        
    }];
    
    return info;
}



@end
