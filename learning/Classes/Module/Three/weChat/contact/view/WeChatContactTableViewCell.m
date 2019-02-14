//
//  WeChatContactTableViewCell.m
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatContactTableViewCell.h"

@implementation WeChatContactTableViewCell
{
    UIImageView *_faceImageView;
    UILabel *_nameLabel;
    CAShapeLayer *_line;
}

- (void)setUpSubViews{
    _faceImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    
    [self.contentView addSubviews:@[_faceImageView,_nameLabel]];
    
    _faceImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _nameLabel.textColor = WeChatRGB40;
    _nameLabel.font = WeChatFont16;
    _nameLabel.numberOfLines = 2;
    
    UIView *referView = self.contentView;
    CGFloat margin = 10.f;
    CGFloat edge = 15.f;
    
    //这里cell的高度是44,如果不是自适应高度，尽可能计算出
    _faceImageView.sd_layout
    .leftSpaceToView(referView, edge)
    .topSpaceToView(referView, margin)
    .widthIs(50)
    .heightIs(50);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_faceImageView, margin)
    .topSpaceToView(referView, margin)
    .rightSpaceToView(referView, edge)
    .heightIs(50);
    
    _line = [self.contentView lineWithRect:CGRectMake(75, 70-0.2, SCREEN_WIDTH-75, 0.2) color:AI_RGB125 dashPattern:nil];
    [self.contentView.layer addSublayer:_line];
}


- (void)setContactModel:(WeChatContactMessage *)contactModel{
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage *image = [IMG(contactModel.photo) circleImageWithCornerRadius:4];
        dispatch_async(dispatch_get_main_queue(), ^{
            _faceImageView.image = image;
        });
        
    });
    
    _nameLabel.text = contactModel.name;
}

- (void)setHiddenLine:(BOOL)hiddenLine{
    _line.hidden = hiddenLine;
}

@end
