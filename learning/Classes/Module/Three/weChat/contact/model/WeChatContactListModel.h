//
//  WeChatContactListModel.h
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeChatContactMessage;

NS_ASSUME_NONNULL_BEGIN
//数组 ： （字典 ：字符串+数组（字典））

@interface WeChatContactListModel : NSObject

//A~Z
@property (nonatomic, copy) NSString *letter;

@property (nonatomic, copy) NSArray<WeChatContactMessage *> *contact;

@end

@interface WeChatContactMessage : NSObject

//头像
@property (nonatomic, copy) NSString *photo;
//id
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
