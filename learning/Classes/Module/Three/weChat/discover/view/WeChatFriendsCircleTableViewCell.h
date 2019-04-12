//
//  WeChatFriendsCircleTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/4/8.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"
#import "WeChatFriendsCircleModel.h"
#import "MLEmojiLabel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, CFClickMessageType) {
    CFClickMessageTypeURL = 0,
    CFClickMessageTypeEmail,
    CFClickMessageTypePhoneNumber,
    CFClickMessageTypeAt,
    CFClickMessageTypePoundSign,
    CFClickMessageTypeButton
};

@interface WeChatFriendsCircleTableViewCell : AIBaseTableViewCell<MLEmojiLabelDelegate>

@property (nonatomic, copy) WeChatFriendsCircleModel *fcModel;

@property (nonatomic, assign) CFClickMessageType messageType;

@property (nonatomic, copy) void (^didSelectLinkBlock)(NSString *link, CFClickMessageType type);

@end

NS_ASSUME_NONNULL_END
