//
//  WeChatHomeTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatHomeTableViewCell.h"
#import "UIView+WZLBadge.h"

@implementation WeChatHomeTableViewCell

{
    UIImageView *_photoImageView;
    UILabel *_nameLabel;
    UILabel *_messageLabel;
    UILabel *_timeLabel;
    UIImageView *_silentImageView;
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
    _photoImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    _messageLabel = [[UILabel alloc]init];
    _timeLabel = [[UILabel alloc]init];
    _silentImageView = [[UIImageView alloc]init];
    
    //这句话需要放在布局前
    [self.contentView addSubviews:@[_photoImageView,_nameLabel,_timeLabel,_messageLabel,_silentImageView]];
    
    _photoImageView.contentMode = _silentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _nameLabel.textColor = WeChatRGB40;
    _nameLabel.font = WeChatFont16;
    
    _messageLabel.textColor = WeChatRGB200;
    _messageLabel.font = WeChatFont12;
    
    _timeLabel.textColor = WeChatRGB200;
    _timeLabel.font = WeChatFont12;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    UIView *referView = self.contentView;
    CGFloat margin = 10.f;
    CGFloat edge = 15.f;
    
    //这里cell的高度是44,如果不是自适应高度，尽可能计算出
    _photoImageView.sd_layout
    .leftSpaceToView(referView, edge)
    .topSpaceToView(referView, margin)
    .widthIs(50)
    .heightIs(50);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_photoImageView, margin)
    .topSpaceToView(referView, margin)
    .rightSpaceToView(referView, 100)
    .heightRatioToView(_photoImageView, 0.5);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_nameLabel, margin)
    .topSpaceToView(referView, margin)
    .rightSpaceToView(referView, edge)
    .heightRatioToView(_photoImageView, 0.5);
    
    _messageLabel.sd_layout
    .leftSpaceToView(_photoImageView, margin)
    .topSpaceToView(_nameLabel, 0)
    .rightSpaceToView(referView, 50)
    .heightRatioToView(_photoImageView, 0.5);
    
    _silentImageView.sd_layout
    .topSpaceToView(_nameLabel, 0)
    .rightSpaceToView(referView, edge)
    .widthIs(edge)
    .heightIs(edge);
    
   
    
    _silentImageView.image = IMG(@"wechat_silent");
    [self.contentView drawLineWithRect:CGRectMake(75, 70-0.2, SCREEN_WIDTH-75, 0.2) color:AI_RGB125];
}

- (void)setMessageListModel:(WeChatMessageListModel *)messageListModel{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage *image = [IMG(messageListModel.photo) circleImageWithCornerRadius:10];
        dispatch_async(dispatch_get_main_queue(), ^{
            _photoImageView.image = image;
        });
        
    });
    
    _nameLabel.text = messageListModel.name;
    
    _messageLabel.text = messageListModel.message;
    
    _timeLabel.text = messageListModel.time;
    
    _silentImageView.hidden = !messageListModel.silent;
    
    messageListModel.unreadCount?
        (messageListModel.silent?
     [_photoImageView showBadge]:
     [_photoImageView showNumberBadgeWithValue:
  messageListModel.unreadCount]):
    [_photoImageView clearBadge];

}

@end
