//
//  UIView+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/11.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIView+tools.h"
#import <objc/runtime.h>

static NSString *tap_touch_block = @"tap_touch_block";

@interface UIView ()

@property (nonatomic, assign) NSInteger viewLevel;

@end

@implementation UIView (tools)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

//----------------------------------------------
+ (instancetype)viewWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor
{
    __kindof UIView *view = [[self alloc]initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;
}

//----------------------------------------------
- (UIViewController *)viewController{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while (next != nil);
    return nil;
}


//----------------------------------------------
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return effectView;
}


//----------------------------------------------
- (void)addSubviews:(NSArray *)views
{
    for (UIView *subview in views) {
        [self addSubview:subview];
    }
}

- (void)removeAllSubView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeAllSubViewExcept:(NSArray *)views
{
    NSArray *arraySubViews = [NSArray arrayWithArray:self.subviews];
    for (UIView *subview in arraySubViews) {
        if (![views containsObject:subview]) {
            [subview removeFromSuperview];
        }
    }
}


//----------------------------------------------
- (void)addTarget:(id)target action:(SEL)action{
    //移除其他点击手势
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UITapGestureRecognizer class]]) {
            [self removeGestureRecognizer:obj];
        }
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)addActionWithBlock:(UITouchBlock)block{
    if (block) {
        objc_setAssociatedObject(self, &tap_touch_block, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        self.userInteractionEnabled = YES;
        [self addTarget:self action:@selector(invoke)];
    }
}

- (void)invoke{
    UITouchBlock block = objc_getAssociatedObject(self, &tap_touch_block);
    if (block) {
        block();
    }
}


//----------------------------------------------
- (BOOL)isDragable{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsDragable:(BOOL)isDragable{
    if (isDragable) {
        //移除其他点击手势
        [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isMemberOfClass:[UIPanGestureRecognizer class]]) {
                [self removeGestureRecognizer:obj];
            }
        }];
        
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(becomeDragable:)];
        [self addGestureRecognizer:pan];
        objc_setAssociatedObject(self, @selector(isDragable), @(isDragable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)becomeDragable:(UIPanGestureRecognizer *)sender{
    CGPoint transP = [sender translationInView:self];
    self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    [sender setTranslation:CGPointZero inView:self];
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.2 animations:^{
            if (VL(self) < 0) {
                VL(self) = 0;
            }
            if (VR(self) > VW(self.superview)) {
                VL(self) = VW(self.superview)-VW(self);
            }
//            if (VHD(self) < VW(self.superview)/2) {
//                VL(self) = 0;
//            }else{
//                VL(self) = VW(self.superview)-VW(self);
//            }
            
            if (VT(self) < 0) {
                VT(self) = 0;
            }
            if (VB(self) > VH(self.superview)) {
                VT(self) = VH(self.superview)-VH(self);
            }
            
        }];
    }
}

//----------------------------------------------
- (void)subViewsList{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.subviews.count) {
            for (UIView *subView in self.subviews) {
                subView.viewLevel = self.viewLevel+1;
#ifdef DEBUG
                DLog(@"层级%02zd-类名%@",subView.viewLevel,[subView class]);
#endif
                [subView subViewsList];
            }
        }
    });
}

- (NSArray *)getSubViewsList{
    NSMutableArray *viewsList = [NSMutableArray array];
    [self setSubViewsList:viewsList];
    return viewsList;
}

- (void)setSubViewsList:(NSMutableArray *)viewsList{
    
    if (self.subviews.count) {
        for (UIView *subView in self.subviews) {
            subView.viewLevel = self.viewLevel+1;
            
            if (viewsList.count > subView.viewLevel-1) {
                NSMutableArray *temp = [NSMutableArray arrayWithArray:viewsList[subView.viewLevel-1]];
                [temp addObject:subView];
                [viewsList replaceObjectAtIndex:subView.viewLevel-1 withObject:temp];
            }else{
                [viewsList addObject:@[subView]];
            }
            [subView setSubViewsList:viewsList];
        }
    }
}

- (NSInteger)viewLevel{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setViewLevel:(NSInteger)viewLevel{
    objc_setAssociatedObject(self, @selector(viewLevel), @(viewLevel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRoundCorners:(UIRectCorner)corners cornerRadii:(CGSize)size{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
}

- (void)drawLineWithRect:(CGRect)rect color:(UIColor *)color{
    [self drawDottedWithRect:rect color:color dashPattern:nil];
}

- (void)drawDottedWithRect:(CGRect)rect color:(UIColor *)color dashPattern:(NSArray<NSNumber *> *)dashPattern{
    
    [self.layer addSublayer:[self lineWithRect:rect color:color dashPattern:dashPattern]];
}

- (CAShapeLayer *)lineWithRect:(CGRect)rect color:(UIColor *)color  dashPattern:(NSArray<NSNumber *> *)dashPattern{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGFloat anchorY = rect.origin.y+rect.size.height/2;
    [bezierPath moveToPoint:CGPointMake(rect.origin.x, anchorY)];
    [bezierPath addLineToPoint:CGPointMake(rect.origin.x+rect.size.width, anchorY)];
    
    CAShapeLayer *lineLayer = [[CAShapeLayer alloc]init];
    lineLayer.lineWidth = rect.size.height;
    lineLayer.strokeColor = color.CGColor;
    lineLayer.path = bezierPath.CGPath;
    if (dashPattern.count) {
        lineLayer.lineDashPattern = dashPattern;
    }
    return lineLayer;
}

@end
