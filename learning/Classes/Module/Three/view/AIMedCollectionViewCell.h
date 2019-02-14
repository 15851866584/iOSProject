//
//  AIMedCollectionViewCell.h
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AIMedCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, copy) IconModel *iconModel;

@end

NS_ASSUME_NONNULL_END
