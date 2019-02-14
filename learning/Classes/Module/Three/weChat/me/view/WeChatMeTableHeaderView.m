//
//  WeChatMeTableHeaderView.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMeTableHeaderView.h"

@implementation WeChatMeTableHeaderView
{
    UIImageView *_faceImageView;
    UILabel *_nameLabel;
    UILabel *_codeLabel;
    
    UIImageView *_unreadImageView;
    UIImageView *_arrowImageView;

}

- (void)setUpSubViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _faceImageView = [[UIImageView alloc]init];
    _unreadImageView = [[UIImageView alloc]init];
    _arrowImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    _codeLabel = [[UILabel alloc]init];
    
    [self.contentView addSubviews:@[_faceImageView,_unreadImageView,_arrowImageView,_nameLabel,_codeLabel]];
    
    _faceImageView.contentMode = _unreadImageView.contentMode = _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _nameLabel.textColor = WeChatRGB20;
    _nameLabel.font = WeChatFontBold24;
    
    _codeLabel.textColor = WeChatRGB160;
    _codeLabel.font = WeChatFont16;
    
    UIView *referView = self.contentView;
    CGFloat margin = 15.f;
    CGFloat top = 100.f;
    
    _faceImageView.sd_layout
    .leftSpaceToView(referView, margin+3)
    .topSpaceToView(referView, top)
    .widthIs(70)
    .heightIs(70);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_faceImageView, margin)
    .topSpaceToView(referView, top)
    .rightSpaceToView(referView, 70)
    .heightIs(40);
    
    _codeLabel.sd_layout
    .leftSpaceToView(_faceImageView, margin)
    .topSpaceToView(_nameLabel, 0)
    .rightSpaceToView(referView, 70)
    .heightIs(30);
    
    _unreadImageView.sd_layout
    .topSpaceToView(_nameLabel, 7)
    .rightSpaceToView(referView, 50)
    .widthIs(16)
    .heightIs(16);
    
    _arrowImageView.sd_layout
    .topSpaceToView(_nameLabel, 8)
    .rightSpaceToView(referView, margin)
    .widthIs(8)
    .heightIs(14);
    
    _unreadImageView.image = IMG(@"wechat_me_QrCode");
    _arrowImageView.image = IMG(@"wechat_discover_arrow");
    
    [self.contentView drawLineWithRect:CGRectMake(0, 200-10, SCREEN_WIDTH, 10) color:WeChatRGB241];
}

- (void)setInfoModel:(WeChatMeInfoModel *)infoModel{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage *image = [IMG(infoModel.photo) circleImageWithCornerRadius:30];
        dispatch_async(dispatch_get_main_queue(), ^{
            _faceImageView.image = image;
        });
        
    });
    
    _nameLabel.text = infoModel.name;
    _codeLabel.text = infoModel.code;
}

@end
