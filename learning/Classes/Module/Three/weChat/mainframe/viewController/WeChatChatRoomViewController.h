//
//  WeChatChatRoomViewController.h
//  learning
//
//  Created by 祥伟 on 2019/3/25.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeChatChatRoomViewController : WeChatViewController
@property (nonatomic, copy) NSString *weChatName;
@property (nonatomic, assign) NSInteger badgeCount;//总未读数
@property (nonatomic, assign) NSInteger unreadCount;//该消息未读数
@end

NS_ASSUME_NONNULL_END
