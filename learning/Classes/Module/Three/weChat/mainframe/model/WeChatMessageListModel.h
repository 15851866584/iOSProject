//
//  WeChatMessageListModel.h
//  learning
//
//  Created by 祥伟 on 2019/1/25.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeChatMessageListModel : NSObject
//头像
@property (nonatomic, copy) NSString *photo;
//id
@property (nonatomic, copy) NSString *name;
//消息
@property (nonatomic, copy) NSString *message;
//时间
@property (nonatomic, copy) NSString *time;
//是否免打扰
@property (nonatomic, assign) BOOL silent;
//未读消息数(正常接收)
@property (nonatomic, assign) NSInteger unreadCount;

@end

NS_ASSUME_NONNULL_END
