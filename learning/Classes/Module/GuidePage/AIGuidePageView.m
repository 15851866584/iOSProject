//
//  AIGuidePageView.m
//  learning
//
//  Created by 祥伟 on 2018/8/14.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIGuidePageView.h"
#import "AICycleScrollView.h"

@interface AIGuidePageView ()<AICycleScrollViewDelegate>

@end

@implementation AIGuidePageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    AICycleScrollView *guidePage = [AICycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self imageStringsGroup:@[@"guid01",@"guid02",@"guid03"] placeholderImage:nil];
    guidePage.autoScroll = NO;
    guidePage.infiniteLoop = NO;
    guidePage.wallPaperImage = IMG(@"IMG_1032");
    [self addSubview:guidePage];
}


- (NSArray *)cycleScrollView:(AICycleScrollView *)cycleScrollView addSubviewsAtIndex:(NSInteger)index{
    if (index == cycleScrollView.imageStringsGroup.count-1) {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(VW(cycleScrollView)-100, 50, 60, 30) textColor:[UIColor redColor] backgroundColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14] text:@"跳过" target:self action:@selector(clickBtnEvent)];
        return @[btn];
    }
    return nil;
}

- (CGRect)cycleScrollViewCustomFrame:(AICycleScrollView *)cycleScrollView{
    return CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-110);
}

- (void)clickBtnEvent{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
