//
//  AIMedCollectionViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIMedCollectionViewCell.h"

static const CGFloat margin = 20;

@implementation AIMedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width - margin;
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin/2, 0, width, width)];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, width, frame.size.width, margin)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = AI_SYSTEM_Size(12);
        
        [self.contentView addSubviews:@[self.iconImageView,self.nameLabel]];
    }
    return self;
}

- (void)setIconModel:(IconModel *)iconModel{
    UIImage *image = IMG(iconModel.icon);
    _iconImageView.image = [image circleImageWithCornerRadius:10];
    _nameLabel.text = iconModel.name;
}

@end
