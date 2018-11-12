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


//swizzleObject

void swizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector);
void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector);

+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

@end
