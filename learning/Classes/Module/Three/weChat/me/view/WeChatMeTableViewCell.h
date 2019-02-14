//
//  WeChatMeTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"
#import "WeChatMeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeChatMeTableViewCell : AIBaseTableViewCell

@property (nonatomic, copy) WeChatMeItem *meModel;
@property (nonatomic, assign) BOOL hiddenLine;

@end

NS_ASSUME_NONNULL_END
