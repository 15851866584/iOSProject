//
//  WeChatFriendsCircleHeaderFooterView.m
//  learning
//
//  Created by 祥伟 on 2019/4/8.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatFriendsCircleHeaderFooterView.h"

#define kfaceImageWidth 80.0f
@implementation WeChatFriendsCircleHeaderFooterView
{
    UIImageView *_backgroundImageView;
    
    UIImageView *_faceImageView;
}

- (void)setUpSubViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.44)];
    _faceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(VW(_backgroundImageView)-kfaceImageWidth-30, VH(_backgroundImageView)-kfaceImageWidth/2, kfaceImageWidth, kfaceImageWidth)];
    [self.contentView addSubviews:@[_backgroundImageView,_faceImageView]];
    
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.clipsToBounds = YES;
    _faceImageView.layer.cornerRadius = 8;
    _faceImageView.layer.masksToBounds = YES;
    
    _backgroundImageView.image = IMG(@"image4.jpg");
    _faceImageView.image = IMG(@"wechat_me_face.jpg");
}

@end
