//
//  AIToastView.m
//  learning
//
//  Created by 祥伟 on 2018/9/10.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIToastView.h"
#import "AITextView.h"

@interface AIToastView ()

@property (nonatomic, assign) CGSize anchor;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) AITextView *contentTextView;

@property (nonatomic, copy)   NSString *content;
@end

@implementation AIToastView

- (instancetype)initWithAnchor:(CGSize)anchor title:(NSString *)title content:(NSString *)content agreement:(NSString *)agreement next:(NSString *)next{
    if (anchor.width <= 0) return nil;
    
    self.anchor = anchor;
    AIToastView *toast = [[AIToastView alloc]init];
    
    if (title.length > 0) {
        self.titleLabel.text = title;
    }
    
    if (content.length > 0) {
        self.content = content;
        self.contentTextView.text = content;
    }
    return toast;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 6, self.anchor.width-32, 48)];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18.0];
        _titleLabel.textColor = AIHEXRGB(0x333333);
        [self addSubview:self.titleLabel];
    }
    return _titleLabel;
}

- (AITextView *)contentTextView{
    if (!_contentTextView) {
        CGRect rect = [self.content boundingRectWithSize:CGSizeMake(self.anchor.width-32, 0) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14.0]} context:nil];
        CGFloat height = rect.size.height+30;
        if (height > self.anchor.height) {
            height = self.anchor.height;
        }
        _contentTextView = [[AITextView alloc]initWithFrame:CGRectMake(16, 60, self.anchor.width-32, height)];
        _contentTextView.text = self.content;
        _contentTextView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        [self addSubview:self.contentTextView];
    }
    return _contentTextView;
}

@end
