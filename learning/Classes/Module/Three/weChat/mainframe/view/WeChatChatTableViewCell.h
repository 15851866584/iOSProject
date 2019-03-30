//
//  WeChatChatTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/3/26.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"
#import "MLEmojiLabel.h"
#import "WeChatChatRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, WeChatClickMessageType) {
    WeChatClickMessageTypeURL = 0,
    WeChatClickMessageTypeEmail,
    WeChatClickMessageTypePhoneNumber,
    WeChatClickMessageTypeAt,
    WeChatClickMessageTypePoundSign,
    WeChatClickMessageTypeImage
};

@interface WeChatChatTableViewCell : AIBaseTableViewCell <MLEmojiLabelDelegate>

@property (nonatomic, copy) WeChatChatRoomModel *messageModel;

@property (nonatomic, assign) WeChatClickMessageType messageType;

@property (nonatomic, copy) void (^didSelectLinkBlock)(NSString *link, WeChatClickMessageType type);

@end

NS_ASSUME_NONNULL_END
