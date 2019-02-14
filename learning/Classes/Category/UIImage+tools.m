//
//  UIImage+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/15.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIImage+tools.h"

@implementation UIImage (tools)

+ (UIImage *)imageStretchableWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)createImageWithColor:(UIColor *)color{
    return [self createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (UIImage *)circleImageWithCornerRadius:(CGFloat)radius{
    if (self.size.width <= 0 || self.size.height <= 0) {
        NSCParameterAssert(self);
    }
    
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    //获得上下文
    CGContextRef content = UIGraphicsGetCurrentContext();
    //贝塞尔曲线绘制path
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    //添加路径
    CGContextAddPath(content, bezierPath.CGPath);
    //剪切
    CGContextClip(content);
    
    [self drawInRect:rect];
    CGContextDrawPath(content, kCGPathFillStroke);
    //从内存中创建新图片对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return image;
}


@end
