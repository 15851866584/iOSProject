//
//  UIButton+tools.m
//  learning
//
//  Created by 祥伟 on 2018/7/6.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIButton+tools.h"
#import <objc/runtime.h>

@interface UIButton()

/** bool 类型   设置是否执行点UI方法 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (tools)

+ (void)load{
    [self swizzleInstanceMethod:@selector(sendAction:to:forEvent:) withSwizzleMethod:@selector(ai_SendAction:to:forEvent:)];
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                     textColor:(UIColor *)color
                          font:(UIFont *)font
                        target:(id)target
                        action:(SEL)action{
    return [self buttonWithFrame:frame textColor:color backgroundColor:[UIColor whiteColor] font:font text:nil target:target action:action];
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                      textColor:(UIColor *)color
                backgroundColor:(UIColor *)bgcolor
                           font:(UIFont *)font
                           text:(NSString *)text
                         target:(id)target
                         action:(SEL)action{
    return [self buttonWithFrame:frame textColor:color backgroundColor:bgcolor font:font text:text image:nil target:target action:action];
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action{
    return [self buttonWithFrame:frame textColor:nil backgroundColor:nil font:nil text:nil image:image target:target action:action];
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                      textColor:(UIColor *)color
                backgroundColor:(UIColor *)bgcolor
                           font:(UIFont *)font
                           text:(NSString *)text
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action{
    __kindof UIButton *button = [[self alloc] initWithFrame:frame];
    if ([font isKindOfClass:[UIFont class]]) {
        button.titleLabel.font = font;
    }
    if ([bgcolor isKindOfClass:[UIColor class]]) {
        button.backgroundColor = bgcolor;
    }
    if ([text isKindOfClass:[NSString class]]) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    if ([image isKindOfClass:[UIImage class]]) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if ([color isKindOfClass:[UIColor class]]) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

//----------------------------------------------
- (void)ai_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([self isKindOfClass:[UIButton class]]) {
        if (self.timeInterval > 0) {
            if (self.isIgnoreEvent) return;
            self.isIgnoreEvent = YES;
            [self performSelector:@selector(setIsIgnoreEvent:) withObject:(id)NO afterDelay:self.timeInterval];
        }
    }
    [self ai_SendAction:action to:target forEvent:event];
}

- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)clickedTimeInterval:(NSTimeInterval)timeInterval{
    self.enabled = NO;
    [self performSelector:@selector(changeEnable) withObject:nil afterDelay:timeInterval];
}

- (void)changeEnable{
    self.enabled = YES;
}

//----------------------------------------------
- (void)setTitlePosition:(TitlePositionType)type spacing:(CGFloat)spacing{
    CGSize imageSize = [self imageForState:self.state].size;
    if (imageSize.height * imageSize.width <= 0) return;
    
    NSString *title = [self titleForState:self.state];
    if (title.length <= 0) return;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    switch (type) {
        case TitlePositionLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width + spacing);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, - titleSize.width);
            break;
        case TitlePositionRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            break;
        case TitlePositionTop:
            self.titleEdgeInsets = UIEdgeInsetsMake(- (imageSize.height + spacing), - imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, - (titleSize.height + spacing), - titleSize.width);
            break;
        case TitlePositionBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0, - titleSize.width);
            break;
        default:
            break;
    }
}

//----------------------------------------------
- (void)setEnlargedEdgeInsets:(UIEdgeInsets)enlargedEdgeInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:enlargedEdgeInsets];
    objc_setAssociatedObject(self, @selector(enlargedEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)enlargedEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, @selector(enlargedEdgeInsets));
    if (value) return [value UIEdgeInsetsValue];
    return UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.enlargedEdgeInsets, UIEdgeInsetsZero)) {
        return [super pointInside:point withEvent:event];
    }

    UIEdgeInsets enlarge = UIEdgeInsetsMake(-self.enlargedEdgeInsets.top, -self.enlargedEdgeInsets.left, -self.enlargedEdgeInsets.bottom, -self.enlargedEdgeInsets.right);
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, enlarge);
    return CGRectContainsPoint(hitFrame, point);
}

//----------------------------------------------
- (void)countDownFromTime:(NSInteger)startTime title:(NSString *)title unitTitle:(NSString *)unitTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __weak typeof(self) weakSelf = self;
    __block NSInteger remainTime = startTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (remainTime <= 0) {
            dispatch_source_cancel(timer);

            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.enabled = YES;
            });
        } else {
            NSString *timeStr = [NSString stringWithFormat:@"%zd", remainTime];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,unitTitle] forState:UIControlStateDisabled];
                weakSelf.enabled = NO;
            });
            remainTime--;
        }
    });
    dispatch_resume(timer);
}

@end
