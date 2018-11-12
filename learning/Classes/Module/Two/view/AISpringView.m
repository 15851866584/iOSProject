//
//  AISpringView.m
//  learning
//
//  Created by 祥伟 on 2018/8/24.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AISpringView.h"

@interface AISpringView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIVisualEffectView *imageEffectV;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AISpringView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews:@[self.imageV,self.imageEffectV,self.titleLabel]];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != _bodyScrollView) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY+AI_NavAndStatusHeight<=0) {
        self.imageV.height = -scrollView.contentOffset.y;
        self.titleLabel.alpha = 0;
    }else{
        self.imageV.height = AI_NavAndStatusHeight;
        self.titleLabel.alpha = 1;
    }
    
    self.imageEffectV.frame = CGRectMake(0, 0, VW(self),VH(self.imageV));
    CGFloat alpha = 1+scrollView.contentOffset.y/VH(self);
    if (alpha >=0 || alpha <=1) {
        self.imageEffectV.alpha = alpha;
    }
    
}

#pragma - mark - setter/getter

- (void)setBodyScrollView:(UIScrollView *)bodyScrollView{
    if ([bodyScrollView isKindOfClass:[UIScrollView class]]) {
        _bodyScrollView = bodyScrollView;
        _bodyScrollView.delegate = self;
        _bodyScrollView.contentInset = UIEdgeInsetsMake(VH(self), 0, 0, 0);
    }
}

- (void)setImage:(UIImage *)image{
    _imageV.image = image;
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
        _imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _imageV;
}

- (UIVisualEffectView *)imageEffectV{
    if (!_imageEffectV) {
        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _imageEffectV = [[UIVisualEffectView alloc]initWithEffect:beffect];
        _imageEffectV.alpha = 0;
        _imageEffectV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _imageEffectV;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, AI_StatusBarHeight, VW(self), 44)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}

@end
