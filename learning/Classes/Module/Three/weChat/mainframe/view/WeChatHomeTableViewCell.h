//
//  WeChatHomeTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"
#import "WeChatMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeChatHomeTableViewCell : AIBaseTableViewCell

@property (nonatomic, copy) WeChatMessageListModel *messageListModel;

@end

NS_ASSUME_NONNULL_END
