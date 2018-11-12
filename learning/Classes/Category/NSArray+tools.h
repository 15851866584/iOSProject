//
//  NSArray+tools.h
//  learning
//
//  Created by 祥伟 on 2018/7/9.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (tools)

/*
 * 排序
 */
//冒泡排序(优化)
+ (instancetype)mp_orderedAscending:(NSArray *)arr;
+ (instancetype)mp_orderedDescending:(NSArray *)arr;
//选择排序
+ (instancetype)xz_orderedAscending:(NSArray *)arr;
+ (instancetype)xz_orderedDescending:(NSArray *)arr;


@end
