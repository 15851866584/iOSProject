//
//  AIBaseTableViewCell.h
//  learning
//
//  Created by 祥伟 on 2018/6/20.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIBaseTableViewCell : UITableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView;//同一个cell复用
+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;//多个cell建议使用这种，内存优化
- (void)setUpSubViews;

@end
