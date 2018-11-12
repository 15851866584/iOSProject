//
//  BacktraceLogger.h
//  learning
//
//  Created by 祥伟 on 2018/9/4.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BacktraceLogger : NSObject

/*!
 *  @brief  线程堆栈上下文输出
 */
+ (NSString *)lsl_backtraceOfAllThread;
+ (NSString *)lsl_backtraceOfMainThread;
+ (NSString *)lsl_backtraceOfCurrentThread;
+ (NSString *)lsl_backtraceOfNSThread:(NSThread *)thread;

+ (void)lsl_logMain;
+ (void)lsl_logCurrent;
+ (void)lsl_logAllThread;

+ (NSString *)backtraceLogFilePath;
+ (void)recordLoggerWithFileName: (NSString *)fileName;

@end
