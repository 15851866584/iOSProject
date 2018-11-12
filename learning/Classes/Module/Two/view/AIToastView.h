//
//  AIToastView.h
//  learning
//
//  Created by 祥伟 on 2018/9/10.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIToastView : UIView

- (instancetype)initWithAnchor:(CGSize)anchor title:(NSString *)title content:(NSString *)content agreement:(NSString *)agreement next:(NSString *)next;

@end
