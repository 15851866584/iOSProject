//
//  NSObject+Tools.h
//  learning
//
//  Created by 祥伟 on 2018/8/17.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tools)

//kvc修改属性值
- (void)changeValueForProperty:(NSDictionary *)property;

//自定义赋值方式
- (void)customValueForProperty:(NSDictionary *)property;

//自定义添加属性
- (NSDictionary *)customPropertyGenericClass;

//打印
+ (void)printPropertysList:(Class)cla;

+ (void)printIvarsList:(Class)cla;

+ (void)printAllIvarsList:(Class)cla;


//Method执行者
- (void)performMethod:(NSString *)method;
- (void)performMethod:(NSString *)method withObject:(id)object;
- (void)performMethod:(NSString *)method withObject:(id)object1 withObject:(id)object2;

- (void)performMethod:(NSString *)method withBool:(id)object;
- (void)performMethod:(NSString *)method withObject:(id)object1 withBool:(BOOL)object2;

//swizzleObject

+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

@end
