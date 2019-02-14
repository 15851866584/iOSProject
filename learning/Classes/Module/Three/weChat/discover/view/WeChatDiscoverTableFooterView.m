//
//  WeChatDiscoverTableFooterView.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatDiscoverTableFooterView.h"

@implementation WeChatDiscoverTableFooterView

- (void)setUpSubViews{
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    clearView.backgroundColor = WeChatRGB241;
    [self.contentView addSubview:clearView];
}

@end
