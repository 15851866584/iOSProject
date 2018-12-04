//
//  Code.h
//  learning
//
//  Created by 祥伟 on 2018/11/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Code : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSArray *array;
@end
