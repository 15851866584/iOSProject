//
//  AITools.h
//  learning
//
//  Created by 祥伟 on 2018/12/29.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AITools : NSObject
/*
 **  设备的基础信息
 **  UUID、MAC、IDFA
 **  设备信息：系统版本号、app版本号、bundleID
 **  是否越狱
 */

//keychain Manager
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)saveForKey:(NSString *)service data:(id)data;

+ (id)loadForKey:(NSString *)service;

+ (void)deleteForKey:(NSString *)service;

//UUID Manager
+ (void)saveUUID:(NSString *)UUID;

+ (NSString *)readUUID;

+ (void)deleteUUID;



@end

NS_ASSUME_NONNULL_END
