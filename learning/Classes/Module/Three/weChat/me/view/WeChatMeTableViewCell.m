//
//  WeChatMeTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMeTableViewCell.h"

@implementation WeChatMeTableViewCell
{
    UIImageView *_faceImageView;
    UILabel *_nameLabel;
    
    UIImageView *_unreadImageView;
    UIImageView *_arrowImageView;
    CAShapeLayer *_line;
}

- (void)setUpSubViews{
    _faceImageView = [[UIImageView alloc]init];
    _unreadImageView = [[UIImageView alloc]init];
    _arrowImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    
    [self.contentView addSubviews:@[_faceImageView,_unreadImageView,_arrowImageView,_nameLabel]];
    
    _faceImageView.contentMode = _unreadImageView.contentMode = _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _nameLabel.textColor = WeChatRGB40;
    _nameLabel.font = WeChatFont16;
    _nameLabel.numberOfLines = 2;
    
    UIView *referView = self.contentView;
    CGFloat margin = 15.f;
    CGFloat edge = 15.f;
    
    //这里cell的高度是44,如果不是自适应高度，尽可能计算出
    _faceImageView.sd_layout
    .leftSpaceToView(referView, edge)
    .topSpaceToView(referView, margin+7)
    .widthIs(26)
    .heightIs(26);
    
    _unreadImageView.sd_layout
    .topSpaceToView(referView, margin)
    .rightSpaceToView(referView, 30)
    .widthIs(40)
    .heightIs(40);
    
    _arrowImageView.sd_layout
    .topSpaceToView(referView, margin*2)
    .rightSpaceToView(referView, margin)
    .widthIs(8)
    .heightIs(14);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_faceImageView, margin)
    .topSpaceToView(referView, margin)
    .rightSpaceToView(referView, edge)
    .heightIs(40);
    
    _line = [self.contentView lineWithRect:CGRectMake(75, 70-0.2, SCREEN_WIDTH-75, 0.2) color:AI_RGB125 dashPattern:nil];
    [self.contentView.layer addSublayer:_line];
    
    _arrowImageView.image = IMG(@"wechat_discover_arrow");
}

- (void)setMeModel:(WeChatMeItem *)meModel{
    _faceImageView.image = IMG(meModel.photo);
    
    _nameLabel.text = meModel.name;
}

- (void)setHiddenLine:(BOOL)hiddenLine{
    _line.hidden = hiddenLine;
}

@end
