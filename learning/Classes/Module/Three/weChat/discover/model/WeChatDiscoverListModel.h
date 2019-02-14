//
//  WeChatDiscoverListModel.h
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeChatDiscoverItem;

NS_ASSUME_NONNULL_BEGIN

@interface WeChatDiscoverListModel : NSObject

@property (nonatomic, copy) NSArray <WeChatDiscoverItem *>*item;

@end

@interface WeChatDiscoverItem : NSObject

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
