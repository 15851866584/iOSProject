//
//  AIBaseTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2018/6/20.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIBaseTableViewCell.h"

@implementation AIBaseTableViewCell

static NSString *_static_identifier = nil;

+ (instancetype)initWithTableView:(UITableView *)tableView{
    //对静态变量内存的优化
    if (![_static_identifier isEqualToString:NSStringFromClass([self class])]) {
        _static_identifier = NSStringFromClass([self class]);
    }
    return [self initWithTableView:tableView andIdentifier:_static_identifier];
}

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
}

@end
