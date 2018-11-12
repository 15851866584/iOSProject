//
//  UIAlertController+tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/28.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (tools)

typedef void (^okBlock)(NSUInteger index);
typedef void (^cancelBlock)(NSString *cancel);

/**
 *  alert弹框，仅带取消
 *
 *  @param title        标题
 *  @param message      信息
 *  @param cancelTitle  取消标题
 */
+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel;

/**
 *  alert弹框，取消和确认
 *
 *  @param title        标题
 *  @param message      信息
 *  @param cancelTitle  取消标题
 *  @param okTitle      确认标题
 */
+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel okTitle:(NSString *)okTitle ok:(okBlock)ok;

/**
 *  alert弹框，取消和其他
 *
 *  @param style        样式
 *  @param title        标题
 *  @param message      信息
 *  @param cancelTitle  取消标题
 *  @param oksTitle     其他标题
 */
+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel  oksTitle:(NSArray *)oksTitle ok:(okBlock)ok;

@end
