//
//  NSArray+tools.m
//  learning
//
//  Created by 祥伟 on 2018/7/9.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "NSArray+tools.h"

@implementation NSArray (tools)

+ (instancetype)mp_orderedAscending:(NSArray *)arr{
    BOOL flag;
    NSMutableArray *temp = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i < temp.count - 1; i++) {
        flag = YES;
        for (int j = 0; j < temp.count - 1 - i; j++) {
            if ([temp[j] floatValue] > [temp[j+1] floatValue]){
                [temp exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = NO;
            }
        }
        if (flag) {
            return temp;
        }
    }
    return temp;
}

+ (instancetype)mp_orderedDescending:(NSArray *)arr{
    BOOL flag;
    NSMutableArray *temp = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i < temp.count - 1; i++) {
        flag = YES;
        for (int j = 0; j < temp.count - 1 - i; j++) {
            if ([temp[j] floatValue] < [temp[j+1] floatValue]){
                [temp exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = NO;
            }
        }
        if (flag) {
            return temp;
        }
    }
    return temp;
}

+ (instancetype)xz_orderedAscending:(NSArray *)arr{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0 ; i < temp.count; i++) {
        for (int j = i + 1; j < temp.count; j++) {
            if ([temp[i] floatValue] > [temp[j] floatValue]) {
                [temp exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return temp;
}

+ (instancetype)xz_orderedDescending:(NSArray *)arr{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0 ; i < temp.count; i++) {
        for (int j = i + 1; j < temp.count; j++) {
            if ([temp[i] floatValue] < [temp[j] floatValue]) {
                [temp exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return temp;
}

@end
