//
//  UIAlertController+tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/28.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "UIAlertController+tools.h"

@implementation UIAlertController (tools)

+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel{
    return [self alertTitle:title message:message cancelTitle:cancelTitle cancel:cancel okTitle:nil ok:nil];
}

+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel okTitle:(NSString *)okTitle ok:(okBlock)ok{
    
    NSArray *oks;
    if (okTitle.length) {
        oks = [NSArray arrayWithObject:okTitle];
    }
    return [self alertStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle cancel:cancel oksTitle:oks ok:ok];
}

+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancel  oksTitle:(NSArray *)oksTitle ok:(okBlock)ok{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (cancelTitle.length) {
        [alertVC addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) cancel(action.title);
        }]];
    }
    
    [oksTitle enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertVC addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (ok) ok(idx);
        }]];
    }];
    return alertVC;
}

@end
