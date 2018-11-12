//
//  UILabel+tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (tools)

//init
+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font;

+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font
                       text:(NSString *)text;

+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font
                       text:(NSString *)text
              textAlignment:(NSTextAlignment)alignment;

//设置Label的行间距
- (void)setLineSpaceWithString:(CGFloat)lineSpace;
//设置Label的高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

+ (CGFloat)getLabelHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;

/*
 *  添加菊花
 *  场景：调用对象方法需要先确定font的大小，并且文字居中显示
 */
- (void)startActivityIndicator;
- (void)startActivityIndicatorColor:(UIColor *)color;
- (void)stopActivityIndicator;

@end
