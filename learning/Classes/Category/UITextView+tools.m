//
//  UITextView+tools.m
//  learning
//
//  Created by 祥伟 on 2018/9/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UITextView+tools.h"

@implementation UITextView (tools)

+ (instancetype)sharedInstance{
    static UITextView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UITextView alloc]init];
    });
    return instance;
}

+ (CGFloat)getTextViewHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width{
    UITextView *textViewH = [self sharedInstance];
    textViewH.size = CGSizeMake(width, MAXFLOAT);
    textViewH.text = text;
    textViewH.font = font;
    [textViewH sizeToFit];
    return textViewH.height;
}

+ (CGFloat)getTextViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width{
    UITextView *textViewH = [self sharedInstance];
    textViewH.size = CGSizeMake(width, MAXFLOAT);
    textViewH.attributedText = attributedString;
    [textViewH sizeToFit];
    return textViewH.height;
}

@end
