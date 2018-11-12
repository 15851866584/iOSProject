//
//  AITextView.h
//  learning
//
//  Created by 祥伟 on 2018/9/10.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickTextViewPartBlock)(NSString *clickText);

@interface AITextView : UITextView

/**
 *  设置textView的部分为下划线，并且使之可以点击 Version >= 10.0
 *
 *  @param linkTextRange 需要下划线的文字范围，如果NSRange范围超出总的内容，将过滤掉
 *  @param color              下划线的颜色，以及下划线上面文字的颜色
 *  @param block              点击文字的时候的回调
 */
- (void)setLinkTextWithRange:(NSRange)linkTextRange withLinkColor:(UIColor *)color withBlock:(clickTextViewPartBlock)block;

@end
