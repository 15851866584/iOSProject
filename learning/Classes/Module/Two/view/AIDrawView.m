//
//  AIDrawView.m
//  learning
//
//  Created by 祥伟 on 2018/6/28.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIDrawView.h"

@implementation AIDrawView


- (void)drawRect:(CGRect)rect {
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;

    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理

    [path moveToPoint:CGPointMake(200.0, 50.0)];//起点

    // Draw the lines
    [path addLineToPoint:CGPointMake(300.0, 100.0)];
    [path addLineToPoint:CGPointMake(260, 200)];
    [path addLineToPoint:CGPointMake(100.0, 200)];
    [path addLineToPoint:CGPointMake(100, 270.0)];
    [path closePath];//第五条线通过调用closePath方法得到的

    [[UIColor redColor] setStroke]; //设置线条颜色
    [[UIColor blueColor] setFill];

    [path stroke];//Draws line 根据坐标点连线
    [path fill];//颜色填充

    
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    CGContextMoveToPoint(ctx, 200.0, 50.0);
//    CGContextAddLineToPoint(ctx, 300.0, 100.0);
//    CGContextAddLineToPoint(ctx, 260.0, 200.0);
//    CGContextAddLineToPoint(ctx, 100.0, 200.0);
//    CGContextAddLineToPoint(ctx, 100.0, 70.0);
//    CGContextClosePath(ctx);
//
//    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
//    CGContextFillPath(ctx);

    
    // 矩形
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(100, 300, 100, 80)]];
    [path stroke];
    
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 400, 100, 80) byRoundingCorners:(UIRectCornerTopLeft) cornerRadii:CGSizeMake(40, 40)]];
    [path stroke];
    
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(300,300) radius:90 startAngle:0 endAngle:DegreesToRadian(120) clockwise:NO]];
    [path stroke];
    
    
    [path moveToPoint:CGPointMake(20, 600)];
    [path addCurveToPoint:CGPointMake(260, 600) controlPoint1:CGPointMake(140, 400) controlPoint2:CGPointMake(140, 800)];

    [path stroke];
     
    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = CGRectMake(0, 0, self.width, self.height);
//
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.frame = CGRectMake(0, 0, self.width, self.height);
//    borderLayer.lineWidth = 1.f;
//    borderLayer.strokeColor = [UIColor redColor].CGColor;
//    borderLayer.fillColor = [UIColor clearColor].CGColor;

}


@end
