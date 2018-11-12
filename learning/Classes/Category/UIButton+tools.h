//
//  UIButton+tools.h
//  learning
//
//  Created by 祥伟 on 2018/7/6.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

//文字图片位置类型
typedef NS_ENUM(NSInteger, TitlePositionType) {
    TitlePositionLeft,
    TitlePositionRight,
    TitlePositionTop,
    TitlePositionBottom
};

@interface UIButton (tools)

+ (instancetype)buttonWithFrame:(CGRect)frame
                     textColor:(UIColor *)color
                          font:(UIFont *)font
                        target:(id)target
                        action:(SEL)action;

+ (instancetype)buttonWithFrame:(CGRect)frame
                     textColor:(UIColor *)color
                backgroundColor:(UIColor *)bgcolor
                          font:(UIFont *)font
                          text:(NSString *)text
                        target:(id)target
                        action:(SEL)action;

+ (instancetype)buttonWithFrame:(CGRect)frame
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action;

+ (instancetype)buttonWithFrame:(CGRect)frame
                      textColor:(UIColor *)color
                backgroundColor:(UIColor *)bgcolor
                           font:(UIFont *)font
                           text:(NSString *)text
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action;
/*
 *  图片和标题排版
 *  This method does not take effect until the button sets the image and text
 */
- (void)setTitlePosition:(TitlePositionType)type spacing:(CGFloat)spacing;

/*
 *  Expand the click area of the button
 */
@property (nonatomic,assign) UIEdgeInsets enlargedEdgeInsets;

/*
 *  Set the hit interval value > zero trigger
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;


- (void)clickedTimeInterval:(NSTimeInterval)timeInterval;

/* ----------------------------------------------------- */

/*
 *  倒计时按钮    缺点：切到后台该线程sleep，需要额外开辟任务
 *
 *  @param startTime 倒计时时间
 *  @param title     倒计时结束按钮上显示的文字
 *  @param unitTitle 倒计时的时间单位（默认为s）
 *  @param mColor    按钮的背景色
 *  @param color     倒计时中按钮的背景色
 */
- (void)countDownFromTime:(NSInteger)startTime title:(NSString *)title unitTitle:(NSString *)unitTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/* ----------------------------------------------------- */

@end
