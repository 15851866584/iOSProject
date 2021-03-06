//
//  NSObject+Tools.h
//  learning
//
//  Created by 祥伟 on 2018/8/17.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tools)

//这里为项目开发方便定义一个统一数据源，大家请忽略
+ (id)responseObject;//网络
+ (id)localData;//本地

//打印
+ (void)printPropertysList:(Class)cla;

+ (void)printIvarsList:(Class)cla;

+ (void)printAllIvarsList:(Class)cla;

//Method执行者
- (void)performMethod:(NSString *)method;
- (void)performMethod:(NSString *)method withObject:(id)object;
- (void)performMethod:(NSString *)method withObject:(id)object1 withObject:(id)object2;

- (void)performMethod:(NSString *)method withBool:(BOOL)object;
- (void)performMethod:(NSString *)method withObject:(id)object1 withBool:(BOOL)object2;

//swizzleObject

+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

@end
