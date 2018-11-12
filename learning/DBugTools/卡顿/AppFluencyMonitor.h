//
//  AppFluencyMonitor.h
//  learning
//
//  Created by 祥伟 on 2018/9/4.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFluencyMonitor : NSObject

+ (instancetype)monitor;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
