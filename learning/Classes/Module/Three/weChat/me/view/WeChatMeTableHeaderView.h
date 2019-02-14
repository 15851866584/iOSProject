//
//  WeChatMeTableHeaderView.h
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewHeaderFooterView.h"
#import "WeChatMeInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeChatMeTableHeaderView : AIBaseTableViewHeaderFooterView
@property (nonatomic, copy) WeChatMeInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
