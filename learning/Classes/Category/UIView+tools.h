//
//  UIView+tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/11.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITouchBlock)(void);

@interface UIView (tools)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;


//是否可以拖拽 area：superview
@property (nonatomic, assign) BOOL isDragable;

+ (instancetype)viewWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor;

- (void)addSubviews:(NSArray *)views;
- (void)removeAllSubView;
- (void)removeAllSubViewExcept:(NSArray *)views;

//添加点击手势
- (void)addTarget:(id)target action:(SEL)action;
- (void)addActionWithBlock:(UITouchBlock)block;

//毛玻璃
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;

//根据view获得vc
- (UIViewController *)viewController;

//获得view的所有子视图
- (void)subViewsList;
- (NSArray *)getSubViewsList;

//设置视图圆角
- (void)setRoundCorners:(UIRectCorner)corners cornerRadii:(CGSize)size;

//画直线、虚线
- (void)drawLineWithRect:(CGRect)rect color:(UIColor *)color;
- (void)drawDottedWithRect:(CGRect)rect color:(UIColor *)color dashPattern:(NSArray<NSNumber *> *)dashPattern;
- (CAShapeLayer *)lineWithRect:(CGRect)rect color:(UIColor *)color  dashPattern:(NSArray<NSNumber *> *)dashPattern;
//
@end
