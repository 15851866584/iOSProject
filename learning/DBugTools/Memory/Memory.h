//
//  Memory.h
//  learning
//
//  Created by 祥伟 on 2018/9/4.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memory : NSObject

//内存占用，和Xcode数值相差较大
+ (double)getResidentMemory;

//内存占用，和Xcode数值相近
+ (double)getMemoryUsage;

@end
