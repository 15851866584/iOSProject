//
//  AIBaseTableViewHeaderFooterView.h
//  learning
//
//  Created by 祥伟 on 2018/7/24.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIBaseTableViewHeaderFooterView : UITableViewHeaderFooterView

+ (instancetype)initWithTableView:(UITableView *)tableView;

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

- (void)setUpSubViews;

@end
