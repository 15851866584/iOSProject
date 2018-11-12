//
//  UITextView+tools.h
//  learning
//
//  Created by 祥伟 on 2018/9/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (tools)

//设置textView的高度
+ (CGFloat)getTextViewHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

+ (CGFloat)getTextViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;

@end
