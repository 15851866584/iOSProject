//
//  AIBaseTableViewHeaderFooterView.m
//  learning
//
//  Created by 祥伟 on 2018/7/24.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIBaseTableViewHeaderFooterView.h"

@implementation AIBaseTableViewHeaderFooterView

static NSString *_static_identifier = nil;

+ (instancetype)initWithTableView:(UITableView *)tableView{
    _static_identifier = NSStringFromClass([self class]);
    return [self initWithTableView:tableView andIdentifier:_static_identifier];
}

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    id view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!view) {
        view = [[self alloc] initWithReuseIdentifier:identifier];
    }
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
}

@end
