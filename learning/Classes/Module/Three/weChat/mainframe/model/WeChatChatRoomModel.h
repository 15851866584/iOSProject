//
//  WeChatChatRoomModel.h
//  learning
//
//  Created by 祥伟 on 2019/3/27.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CRMessageTypeOthers,
    CRMessageTypeMine
} CRMessageType;


@interface WeChatChatRoomModel : NSObject
//头像
@property (nonatomic, copy) NSString *photo;
//消息文本
@property (nonatomic, copy) NSString *messageText;
//消息图片
@property (nonatomic, copy) NSString *messageImage;
//消息来源
@property (nonatomic, assign) CRMessageType messageType;

@end

NS_ASSUME_NONNULL_END
