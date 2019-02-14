//
//  WeChatContactTableViewHeaderFooterView.m
//  learning
//
//  Created by 祥伟 on 2019/1/30.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatContactTableViewHeaderFooterView.h"

@implementation WeChatContactTableViewHeaderFooterView

{
    UILabel *_letterLabel;
}

- (void)setUpSubViews{
    _letterLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 30)];
    _letterLabel.font = WeChatFont14;
    _letterLabel.textColor = WeChatRGB110;
    [self.contentView addSubview:_letterLabel];
    
    
}

- (void)setLetter:(NSString *)letter{
    _letterLabel.text = letter;
}

@end
