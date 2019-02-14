//
//  WeChatHomeMenuView.m
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatHomeMenuView.h"

const CGFloat topHeight = 6.f;
const CGFloat menuHeight = 55.f;

@implementation WeChatHomeMenuView


- (instancetype)init{
    if (self = [super init]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    self.backgroundColor = [UIColor clearColor];
    
    NSInteger count = [self titles].count;
    CGFloat width = 150.f;
    self.frame = CGRectMake(0, AI_NavAndStatusHeight, SCREEN_WIDTH, SCREEN_HEIGHT-AI_NavAndStatusHeight-AI_TabbarHeight);
    
    UIImageView *backgroundIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-width-10, 0, width, menuHeight*count+topHeight)];
    UIImage *image = [UIImage imageStretchableWithName:@"wechat_home_menu"];
    backgroundIV.image = image;
     [self addSubview:backgroundIV];
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, menuHeight*i+topHeight, width, menuHeight)];
        NSString *imageStr = [self images][i];
        [btn setImage:IMG(imageStr) forState:0];
        btn.showsTouchWhenHighlighted = NO;
        NSString *title = [self titles][i];
        [btn setTitle:title forState:0];
        
        //居左
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 22, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        //添加事件
        [btn addTarget:self action:@selector(clickHomeMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundIV addSubview:btn];
    }
    
   
    
    for (int i = 1;i < count;i++) {
        [backgroundIV drawLineWithRect:CGRectMake(50, i*menuHeight+topHeight, width, 0.2) color:WeChatRGB256];
    }
    
}

- (void)clickHomeMenu:(UIButton *)sender{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

- (NSArray *)titles{
    return @[
             @"发起群聊",
             @"添加朋友",
             @"扫一扫",
             @"收付款"
             ];
}

- (NSArray *)images{
    return @[
             @"wechat_home_menu_groupchat",
             @"wechat_home_menu_addfriend",
             @"wechat_home_menu_scan",
             @"wechat_home_menu_pay"
             ];
}

@end
