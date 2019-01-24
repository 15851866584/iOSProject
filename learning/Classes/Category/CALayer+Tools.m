//
//  CALayer+Tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/19.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "CALayer+Tools.h"

@implementation CALayer (Tools)

- (void)drawCircleRotate{
    
    // 圆环颜色
    CGColorRef CIRCLE_COLOR = [UIColor whiteColor].CGColor;
    
    // 环形宽度默认 3.0f
    const float CIRCLE_WIDTH = 3.0;
    
    // 内环直径
    const float CIRCLE_RADIUS = self.bounds.size.width / 2 - CIRCLE_WIDTH;
    
    const float CIRCLE_START = DegreesToRadian(0);
    const float CIRCLE_END   = DegreesToRadian(360);
    
    // 环形中心
    CGPoint CIRCLE_POINT = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // 绘制圆形路径
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    [bottomPath addArcWithCenter:CIRCLE_POINT radius:CIRCLE_RADIUS startAngle:CIRCLE_START endAngle:CIRCLE_END clockwise:NO];
    
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    [topPath addArcWithCenter:CIRCLE_POINT radius:CIRCLE_RADIUS startAngle:CIRCLE_START endAngle:CIRCLE_END clockwise:YES];
    
    // 绘图
    CAShapeLayer *bottomLayer = [CAShapeLayer layer];
    bottomLayer.path = bottomPath.CGPath;// 设置透明圆形的绘图路径
    bottomLayer.strokeColor = [[UIColor colorWithCGColor:CIRCLE_COLOR] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    bottomLayer.lineWidth = CIRCLE_WIDTH;// 设置圆形的线宽
    bottomLayer.fillColor = [UIColor clearColor].CGColor;
    
    CAShapeLayer *topLayer = [CAShapeLayer layer];
    topLayer.path = topPath.CGPath;
    topLayer.strokeColor = CIRCLE_COLOR;
    topLayer.lineWidth = CIRCLE_WIDTH;
    topLayer.fillColor = [UIColor clearColor].CGColor;
    topLayer.frame = self.bounds;
    
    [self addSublayer:bottomLayer];
    [self addSublayer:topLayer];
    
    // 动画
    CABasicAnimation *progressLongEndAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    progressLongEndAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongEndAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongEndAnimation.duration = 2.0;
    CAMediaTimingFunction *strokeStartTimingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints: 0.65 : 0.0 :1.0 : 1.0];
    progressLongEndAnimation.timingFunction = strokeStartTimingFunction;
    progressLongEndAnimation.repeatCount = MAXFLOAT;
    progressLongEndAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *progressLongAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    progressLongAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongAnimation.duration = 2.0;
    CAMediaTimingFunction *progressRotateTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.80 :0.75 :1.00];
    progressLongAnimation.timingFunction = progressRotateTimingFunction;
    progressLongAnimation.repeatCount = MAXFLOAT;
    progressLongAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *progressRotateAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    progressRotateAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressRotateAnimation.toValue = [NSNumber numberWithFloat:CIRCLE_END];
    progressRotateAnimation.repeatCount = MAXFLOAT;
    progressRotateAnimation.duration = 6;
    progressRotateAnimation.removedOnCompletion = NO;
    
    [topLayer addAnimation:progressLongEndAnimation forKey:@"strokeStart"];
    [topLayer addAnimation:progressLongAnimation forKey:@"strokeEnd"];
    [topLayer addAnimation:progressRotateAnimation forKey:@"transfrom.rotation.z"];
}

@end

