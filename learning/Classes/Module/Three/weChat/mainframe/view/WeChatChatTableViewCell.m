//
//  WeChatChatTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/3/26.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatChatTableViewCell.h"

#define kChatMessageTopBottomMargin 20.f //消息的上下间隙
#define kChatBackGroundMargin 10.0f  //背景间隙
#define kChatIconWidthHight 40.f//头像宽高
#define kChatIconMessageMargin 10.f//头像和文本间隙
#define kChatMessageMaxWidth (SCREEN_WIDTH-140)//消息的最大宽度
#define kChatImageReferWidth 120.0f //如果图片宽度大于200，压缩到200

@implementation WeChatChatTableViewCell

{
    UIImageView *_iconPersonalImgView;//个人头像
    MLEmojiLabel *_messageLabel;//消息-文字
    UIImageView *_messageImgView;//消息-图片
    UIImageView *_messageBackground;//消息文字背景图片

}

- (void)setUpSubViews{
    self.contentView.backgroundColor = WeChatRGB241;
    
    //初始化，添加到父视图，配置属性值
    _iconPersonalImgView = [[UIImageView alloc]init];
    _messageLabel = [MLEmojiLabel new];
    _messageImgView = [[UIImageView alloc]init];
    _messageBackground = [[UIImageView alloc]init];
    
    [self.contentView addSubviews:@[_iconPersonalImgView,_messageBackground]];
    [_messageBackground addSubviews:@[_messageLabel,_messageImgView]];
    
    
    _iconPersonalImgView.contentMode = _messageImgView.contentMode = UIViewContentModeScaleAspectFit;
    _messageLabel.font = WeChatFont16;
    _messageLabel.textColor = WeChatRGB20;
    _messageLabel.numberOfLines = 0;
    _messageLabel.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _messageLabel.isAttributedContent = YES;
    _messageLabel.delegate = self;
    _messageLabel.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName:WeChatGreen};
    _messageLabel.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName:WeChatGreen};
    
    _messageBackground.userInteractionEnabled = YES;
    
    [self setupAutoHeightWithBottomView:_messageBackground bottomMargin:0];

    [_messageImgView addTarget:self action:@selector(didSelectMessageImgView)];
}

- (void)setMessageModel:(WeChatChatRoomModel *)messageModel{
    _messageModel = messageModel;
    
    // 清空之前的约束（只有在cell布局变化非常大的情况下，一般自动布局不需要这样处理）
    _iconPersonalImgView.frame = CGRectZero;
    _messageLabel.frame = CGRectZero;
    _messageImgView.frame = CGRectZero;
    _messageBackground.frame = CGRectZero;
    [_iconPersonalImgView sd_clearAutoLayoutSettings];
    [_messageLabel sd_clearAutoLayoutSettings];
    [_messageImgView sd_clearAutoLayoutSettings];
    [_messageBackground sd_clearAutoLayoutSettings];

    

    _iconPersonalImgView.image = IMG(_messageModel.photo);
    
    //重新布局  这里为了方便阅读，将文本和图片区分开来
    
    if (_messageModel.messageImage.length>0) {
        _messageImgView.image = IMG(_messageModel.messageImage);;
        [self updateLayoutImage];
    }else{
        _messageLabel.text = _messageModel.messageText;
        [self updateLayoutMessage];
    }
}

//文本布局
- (void)updateLayoutMessage{

    if (_messageModel.messageType == CRMessageTypeOthers) {
        
        UIView *referView = self.contentView;
        _iconPersonalImgView.sd_resetLayout
        .leftSpaceToView(referView, kChatBackGroundMargin)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(kChatIconWidthHight)
        .heightIs(kChatIconWidthHight);
        
        _messageBackground.sd_resetLayout
        .topSpaceToView(referView, kChatBackGroundMargin)
        .leftSpaceToView(_iconPersonalImgView, 5);
        
        _messageBackground.image = [[UIImage imageNamed:@"wechat_home_chat_other"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }else{
        
        UIView *referView = self.contentView;
        _iconPersonalImgView.sd_resetLayout
        .rightSpaceToView(referView, kChatBackGroundMargin)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(kChatIconWidthHight)
        .heightIs(kChatIconWidthHight);
        
        _messageBackground.sd_resetLayout
        .topSpaceToView(referView, kChatBackGroundMargin)
        .rightSpaceToView(_iconPersonalImgView, 5);
        
        _messageBackground.image = [[UIImage imageNamed:@"wechat_home_chat_mine"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }
    
    
    _messageLabel.sd_resetLayout
    .leftSpaceToView(_messageBackground, kChatMessageTopBottomMargin)
    .topSpaceToView(_messageBackground, kChatBackGroundMargin+3)
    .autoHeightRatio(0);
    
    // 设置_messageLabel横向自适应
    [_messageLabel setSingleLineAutoResizeWithMaxWidth:kChatMessageMaxWidth];
    // 设置_messageBackground宽度自适应
    [_messageBackground setupAutoWidthWithRightView:_messageLabel rightMargin:kChatMessageTopBottomMargin];
    // 设置_messageBackground高度自适应
    [_messageBackground setupAutoHeightWithBottomView:_messageLabel bottomMargin:kChatMessageTopBottomMargin];

}

//图片布局
- (void)updateLayoutImage{
    // cell重用时候清除只有文字的情况下设置的container宽度自适应约束
    [_messageBackground clearAutoWidthSettings];
    
    UIImage *image = IMG(_messageModel.messageImage);
    CGFloat h = image.size.height;
    CGFloat w = image.size.width;
    CGFloat widthHeightRatio = 0;
    
    if (w > kChatImageReferWidth) {
        
        widthHeightRatio = kChatImageReferWidth/w;
        w = kChatImageReferWidth;
        h = h*widthHeightRatio;
    }
    
    CGFloat minHeight = kChatIconWidthHight+kChatIconMessageMargin*2;
    if (h < minHeight) {
        widthHeightRatio = minHeight/h;
        h = minHeight;
        w = w*widthHeightRatio;
    }
   
    if (_messageModel.messageType == CRMessageTypeOthers) {
        
        UIView *referView = self.contentView;
        _iconPersonalImgView.sd_resetLayout
        .leftSpaceToView(referView, kChatBackGroundMargin)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(kChatIconWidthHight)
        .heightIs(kChatIconWidthHight);
        
        _messageBackground.sd_resetLayout
        .leftSpaceToView(_iconPersonalImgView, kChatBackGroundMargin+5)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(w)
        .heightIs(h);
        
        
    }else{
        
        UIView *referView = self.contentView;
        _iconPersonalImgView.sd_resetLayout
        .rightSpaceToView(referView, kChatBackGroundMargin)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(kChatIconWidthHight)
        .heightIs(kChatIconWidthHight);
        
        _messageBackground.sd_resetLayout
        .rightSpaceToView(_iconPersonalImgView, kChatBackGroundMargin+5)
        .topSpaceToView(referView, kChatBackGroundMargin)
        .widthIs(w)
        .heightIs(h);
        
    }
    
    _messageImgView.sd_resetLayout
    .leftSpaceToView(_messageBackground, 0)
    .rightSpaceToView(_messageBackground, 0)
    .topSpaceToView(_messageBackground, 0)
    .bottomSpaceToView(_messageBackground, 0);
    
    [_messageBackground setupAutoHeightWithBottomView:_messageImgView bottomMargin:0];
    
   
}


//文本链接点击回调
- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type{
    if (self.didSelectLinkBlock) {
        
        switch (type) {
            case MLEmojiLabelLinkTypeURL:
                _messageType = WeChatClickMessageTypeURL;
                break;
            case MLEmojiLabelLinkTypeEmail:
                _messageType = WeChatClickMessageTypeEmail;
                break;
            case MLEmojiLabelLinkTypePhoneNumber:
                _messageType = WeChatClickMessageTypePhoneNumber;
                break;
            case MLEmojiLabelLinkTypeAt:
                _messageType = WeChatClickMessageTypeAt;
                break;
            case MLEmojiLabelLinkTypePoundSign:
                _messageType = WeChatClickMessageTypePoundSign;
                break;
            default:
                break;
        }
        self.didSelectLinkBlock(link, _messageType);
    }
}

//图片点击回调
- (void)didSelectMessageImgView{
    if (self.didSelectLinkBlock) {
        //获得imgView相对window的坐标
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        CGRect rect = [_messageImgView convertRect:_messageImgView.bounds toView:window];
        self.didSelectLinkBlock(NSStringFromCGRect(rect), WeChatClickMessageTypeImage);
    }
}

@end
