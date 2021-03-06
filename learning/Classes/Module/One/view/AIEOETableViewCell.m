//
//  AIEOETableViewCell.m
//  learning
//
//  Created by 祥伟 on 2018/6/20.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIEOETableViewCell.h"

@implementation AIEOETableViewCell

{
    UILabel *_lab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUpSubViews{
    
    _lab = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 50) textColor:AI_RGB51 font:[UIFont systemFontOfSize:16.0]];
    _lab.backgroundColor = [UIColor whiteColor];
    _lab.layer.masksToBounds = YES;
    _lab.numberOfLines = 2;
    [self.contentView addSubview:_lab];
  

    [self.contentView drawLineWithRect:CGRectMake(VL(_lab), 50-0.5, VW(_lab), 0.5) color:AI_RGB125];
}

- (void)setTitle:(NSString *)title{
    _lab.text = title;
}

@end
