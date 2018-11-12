//
//  UILabel+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UILabel+tools.h" 

@implementation UILabel (tools)


+ (instancetype)sharedInstance{
    static UILabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UILabel alloc]init];
    });
    return instance;
}

+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font
{
    return [self labelWithFrame:frame textColor:color font:font text:nil textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font
                       text:(NSString *)text
{
    return [self labelWithFrame:frame textColor:color font:font text:text textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
                       font:(UIFont *)font
                       text:(NSString *)text
              textAlignment:(NSTextAlignment)alignment
{
    __kindof UILabel *label = [[self alloc] initWithFrame:frame];
    label.font = font;
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    
    return label;
}

- (void)setLineSpaceWithString:(CGFloat)lineSpace
{
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}


+ (CGFloat)getLabelHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width{
    UILabel *labelH = [self sharedInstance];
    labelH.size = CGSizeMake(width, MAXFLOAT);
    labelH.numberOfLines = 0;
    labelH.text = text;
    labelH.font = font;
    [labelH sizeToFit];
    return labelH.height;
}

+ (CGFloat)getLabelHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width{
    UILabel *labelH = [self sharedInstance];
    labelH.size = CGSizeMake(width, MAXFLOAT);
    labelH.numberOfLines = 0;
    labelH.attributedText = attributedString;
    [labelH sizeToFit];
    return labelH.height;
}

- (void)startActivityIndicator{
    [self startActivityIndicatorColor:nil];
}

- (void)startActivityIndicatorColor:(UIColor *)color{

    if (self.text.length <= 0) return;
    [self stopActivityIndicator];
    
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat X;
    CGFloat H = size.height;
    
    if (self.textAlignment == NSTextAlignmentLeft) {
        X = -H;
    }else if (self.textAlignment == NSTextAlignmentCenter){
        X = (size.width > self.width)?-H:(self.width-size.width)/2-H;
    }else{
        X = (size.width > self.width)?-H:self.width-size.width-H;
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(X, (self.height-H)/2, H, H)];
    if (color) indicator.color = color;
    [self addSubview:indicator];
    [indicator startAnimating];
 
}

- (void)stopActivityIndicator{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIActivityIndicatorView class]]) {
            UIActivityIndicatorView *indicator = obj;
            if([indicator isAnimating]) [indicator stopAnimating];
            [indicator removeFromSuperview];
        }
    }];
}

@end
