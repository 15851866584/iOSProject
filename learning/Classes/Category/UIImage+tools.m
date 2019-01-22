//
//  UIImage+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/15.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIImage+tools.h"

@implementation UIImage (tools)

+ (UIImage *)imageStretchableWithName:(NSString *)imageName
{
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

+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    //2. 开启上下文
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    CGFloat imageHeight = sourceImage.size.height + 2 * borderWidth;
    CGFloat imageSizeMin = MIN(imageHeight, imageWidth);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSizeMin, imageSizeMin), NO, 2.0);
    //3. 获取当前上下文
    UIGraphicsGetCurrentContext();
    //4. 画圆圈
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageSizeMin * 0.5, imageSizeMin * 0.5) radius:imageSizeMin *0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //5. 使用bezierPath进行剪切
    [bezierPath addClip];
    //6. 画图
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, imageSizeMin, imageSizeMin)];
    //7. 从内存中创建新图片对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //8. 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
