//
//  AISpringView.h
//  learning
//
//  Created by 祥伟 on 2018/8/24.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AISpringView : UIView

//添加到scrollView上
@property (nonatomic, strong) UIScrollView *bodyScrollView;

//添加图片
@property (nonatomic, strong) UIImage *image;

//添加标题
@property (nonatomic, strong) NSString *title;

@end
