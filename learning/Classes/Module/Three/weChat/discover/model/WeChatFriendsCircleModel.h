//
//  WeChatFriendsCircleModel.h
//  learning
//
//  Created by 祥伟 on 2019/4/10.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCFriendsCircImages;
NS_ASSUME_NONNULL_BEGIN

@interface WeChatFriendsCircleModel : NSObject
//头像
@property (nonatomic, copy) NSString *photo;
//id
@property (nonatomic, copy) NSString *name;
//消息 高度超过80折叠
@property (nonatomic, copy) NSString *message;
//消息状态
@property (nonatomic, assign) BOOL open;
//时间
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSArray <WCFriendsCircImages *>*images;

@end

@interface WCFriendsCircImages : NSObject

@property (nonatomic, copy) NSString *originalImage;

@property (nonatomic, copy) NSString *thumbnailImage;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *width;

@end

NS_ASSUME_NONNULL_END
