//
//  WeChatContactTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"
#import "WeChatContactListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeChatContactTableViewCell : AIBaseTableViewCell
@property (nonatomic, copy) WeChatContactMessage *contactModel;
@property (nonatomic, assign) BOOL hiddenLine;
@end

NS_ASSUME_NONNULL_END
