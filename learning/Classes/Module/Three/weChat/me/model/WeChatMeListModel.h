//
//  WeChatMeListModel.h
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeChatMeItem;

NS_ASSUME_NONNULL_BEGIN

@interface WeChatMeListModel : NSObject

@property (nonatomic, copy) NSArray <WeChatMeItem *>*item;

@end

@interface WeChatMeItem : NSObject

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
