//
//  WeChatFriendsCircleTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/4/8.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatFriendsCircleTableViewCell.h"

#define kMessageMaxLine 5//大于最大行数则展示3行

@implementation WeChatFriendsCircleTableViewCell
{
    UIImageView *_faceImageView;
    UILabel *_nameLabel;
    MLEmojiLabel *_messageLabel;
    UIButton *_loadButton;
    PYPhotosView *_photosView;
    UILabel *_releaseTimeLabel;
    UIView *_bottomLineView;
}

- (void)setUpSubViews{
    
    _faceImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    _messageLabel = [MLEmojiLabel new];
    _loadButton = [[UIButton alloc]init];
    _photosView = [PYPhotosView photosView];
    _releaseTimeLabel = [[UILabel alloc]init];
    _bottomLineView = [[UIView alloc]init];
    
    _faceImageView.contentMode = UIViewContentModeScaleAspectFit;
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    _nameLabel.textColor = WeChatPurple;
    _messageLabel.font = WeChatFont16;
    _messageLabel.textColor = WeChatRGB20;
    _messageLabel.numberOfLines = 0;
    _messageLabel.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _messageLabel.isAttributedContent = YES;
    _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _messageLabel.delegate = self;
    _messageLabel.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName:WeChatGreen};
    _messageLabel.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName:WeChatGreen};
    _releaseTimeLabel.font = WeChatFont14;
    _releaseTimeLabel.textColor = WeChatRGB200;
    _bottomLineView.backgroundColor = WeChatRGB234;
    [_loadButton setTitleColor:WeChatPurple forState:UIControlStateNormal];
    _loadButton.titleLabel.font = WeChatFont16;
    _loadButton.selected = NO;
    [_loadButton setTitle:@"全文" forState:UIControlStateNormal];
    [_loadButton setTitle:@"收起" forState:UIControlStateSelected];
    [_loadButton addTarget:self action:@selector(clickLoadButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    _loadButton.enlargedEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _photosView.scrollEnabled = NO;
    
    
    [self.contentView addSubviews:@[_faceImageView,_nameLabel,_messageLabel,_loadButton,_photosView,_releaseTimeLabel,_bottomLineView]];
    

    CGFloat tbMargin = 15;//上下间距
    CGFloat lrMargin = 10;//左右间距
    CGFloat whFace = 40;//头像宽高
    
    UIView *referView = self.contentView;
    
    _faceImageView.sd_layout
    .leftSpaceToView(referView, lrMargin)
    .topSpaceToView(referView, tbMargin)
    .widthIs(whFace)
    .heightEqualToWidth();
    
    _nameLabel.sd_layout
    .leftSpaceToView(_faceImageView, lrMargin)
    .topEqualToView(_faceImageView)
    .rightSpaceToView(referView, lrMargin)
    .heightIs(16);
    
    _messageLabel.sd_layout
    .leftSpaceToView(_faceImageView, lrMargin)
    .topSpaceToView(_nameLabel, lrMargin)
    .widthIs(SCREEN_WIDTH-75)
    .autoHeightRatio(0);
    
    _loadButton.sd_layout
    .leftEqualToView(_messageLabel)
    .topSpaceToView(_messageLabel, lrMargin)
    .widthIs(38)
    .heightIs(15);
    
    _photosView.sd_layout
    .leftEqualToView(_messageLabel)
    .topSpaceToView(_loadButton, lrMargin);
    
    _releaseTimeLabel.sd_layout
    .leftEqualToView(_messageLabel)
    .topSpaceToView(_photosView, lrMargin)
    .widthIs(100)
    .heightIs(14);
    
    _bottomLineView.sd_layout
    .leftSpaceToView(referView, 0)
    .topSpaceToView(_releaseTimeLabel, tbMargin)
    .rightSpaceToView(referView, 0)
    .heightIs(0.5);
    
}


- (void)setFcModel:(WeChatFriendsCircleModel *)fcModel{

    //赋值
    UIImage *image = [IMG(fcModel.photo) circleImageWithCornerRadius:10];
    _faceImageView.image = image;

    _nameLabel.text = fcModel.name;
    _messageLabel.text = fcModel.message;
    _releaseTimeLabel.text = fcModel.time;
    
    NSMutableArray *thumbnailImages = [NSMutableArray array];
    NSMutableArray *originalImages = [NSMutableArray array];
    for (WCFriendsCircImages *item in fcModel.images) {
        [thumbnailImages addObject:item.thumbnailImage];
        [originalImages addObject:item.originalImage];
    }
    _photosView.thumbnailUrls = thumbnailImages;
    _photosView.originalUrls = originalImages;
    
    //重新布局
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fcModel.message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0; // 调整行间距
    NSRange range = NSMakeRange(0, [fcModel.message length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    CGFloat messageH = [UILabel getLabelHeightWithAttributedString:attributedString width:SCREEN_WIDTH-75];
    
    CGFloat photoViewH = _photosView.photoHeight*ceil(thumbnailImages.count/3.0);
    CGFloat photoViewW = 70;
    if (thumbnailImages.count > 1) {
        photoViewW = thumbnailImages.count*(_photosView.photoWidth+_photosView.photoMargin-1);
    }else{
        if ([fcModel.images.firstObject.width floatValue] < SCREEN_WIDTH/2) {
            photoViewH = [fcModel.images.firstObject.width floatValue];
            photoViewW = [fcModel.images.firstObject.height floatValue];
        }
        
    }
    _photosView.sd_layout.heightIs(photoViewH).widthIs(photoViewW);
    
    _loadButton.hidden = messageH > 80 ? NO : YES;
    _photosView.hidden = photoViewH > 0 ? NO : YES;
   
    if (!_loadButton.hidden && !fcModel.open) {
        _messageLabel.sd_layout.maxHeightIs(_messageLabel.font.lineHeight*3+9.71875);
    }else{
        _messageLabel.sd_layout.maxHeightIs(MAXFLOAT);
    }

    CGFloat lrMargin = 10;//左右间距
    if (_loadButton.hidden && _photosView.hidden) {
        _releaseTimeLabel.sd_layout.topSpaceToView(_messageLabel, lrMargin);
    }else if (_loadButton.hidden && !_photosView.hidden){
        _photosView.sd_layout.topSpaceToView(_messageLabel, lrMargin);
        _releaseTimeLabel.sd_layout.topSpaceToView(_photosView, lrMargin);
    }else if (!_loadButton.hidden && _photosView.hidden){
        _loadButton.sd_layout.topSpaceToView(_messageLabel, lrMargin);
        _releaseTimeLabel.sd_layout.topSpaceToView(_loadButton, lrMargin);
    }else{
        _loadButton.sd_layout.topSpaceToView(_messageLabel, lrMargin);
        _photosView.sd_layout.topSpaceToView(_loadButton, lrMargin);
        _releaseTimeLabel.sd_layout.topSpaceToView(_photosView, lrMargin);
    }

    
    [self setupAutoHeightWithBottomView:_bottomLineView bottomMargin:0];
 
}

//按钮点击事件
- (void)clickLoadButtonEvent:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    NSString *open = [NSString stringWithFormat:@"%d",sender.selected];
    if (self.didSelectLinkBlock) {
        self.didSelectLinkBlock(open, CFClickMessageTypeButton);
    }
}

//文本链接点击回调
- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type{
    if (self.didSelectLinkBlock) {
        
        switch (type) {
            case MLEmojiLabelLinkTypeURL:
                _messageType = CFClickMessageTypeURL;
                break;
            case MLEmojiLabelLinkTypeEmail:
                _messageType = CFClickMessageTypeEmail;
                break;
            case MLEmojiLabelLinkTypePhoneNumber:
                _messageType = CFClickMessageTypePhoneNumber;
                break;
            case MLEmojiLabelLinkTypeAt:
                _messageType = CFClickMessageTypeAt;
                break;
            case MLEmojiLabelLinkTypePoundSign:
                _messageType = CFClickMessageTypePoundSign;
                break;
            default:
                break;
        }
        self.didSelectLinkBlock(link, _messageType);
    }
}


@end
