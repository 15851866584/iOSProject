//
//  AICycleScrollView.h
//  learning
//
//  Created by 祥伟 on 2018/8/8.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AICycleScrollView;

typedef NS_ENUM(NSInteger, AICycleScrollViewDragDirection) {
    AICycleScrollViewDragVertical = 0,
    AICycleScrollViewDragHorizontal,
};

typedef NS_ENUM(NSInteger, AICyclePageControlAlignment) {
    AICyclePageControlAlignmentLeft,
    AICyclePageControlAlignmentCenter,
    AICyclePageControlAlignmentRight,
};

@protocol AICycleScrollViewDelegate <NSObject>

@optional

/** 点击图片位置 */
- (void)cycleScrollView:(AICycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动位置 */
- (void)cycleScrollView:(AICycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

/** 图片滚动中 */
- (void)cycleScrollViewDidScroll:(AICycleScrollView *)cycleScrollView;

/** 图片的位置发生变化 */
- (void)cycleScrollView:(AICycleScrollView *)cycleScrollView didChangeToIndex:(NSInteger)index;

/** 添加自定义视图 */
- (NSArray *)cycleScrollView:(AICycleScrollView *)cycleScrollView addSubviewsAtIndex:(NSInteger)index;

/** 添加自定义分页控件 */
- (UIView *)cycleScrollViewCustomPageControl:(AICycleScrollView *)cycleScrollView;

/** 自定义图片视图大小 */
- (CGRect)cycleScrollViewCustomFrame:(AICycleScrollView *)cycleScrollView;

@end

@interface AICycleScrollView : UIView

@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, assign) CGFloat scrollOffset;
/** ---------------------- CycleScrollView ------------------------ */

/** 占位图 */
@property (nonatomic, strong) UIImage *placeholderImage;

/** 壁纸 */
@property (nonatomic, strong) UIImage *wallPaperImage;

/** 图片数组 */
@property (nonatomic, strong) NSArray *imageStringsGroup;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否自动滚动,默认Yes */
@property (nonatomic, assign) BOOL autoScroll;

/** 是否无限循环,默认Yes */
@property (nonatomic, assign) BOOL infiniteLoop;

/** 是否顺时针滚动，默认YES */
@property (nonatomic, assign) BOOL clockwise;

/** 是否禁止逆时针滚动，默认NO */
@property (nonatomic, assign) BOOL estoppage;

/** 图片拖动方向，默认为水平拖动 */
@property (nonatomic, assign) AICycleScrollViewDragDirection dragDirection;

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;

@property (nonatomic, weak) id<AICycleScrollViewDelegate> delegate;


/** ---------------------- PageControl ------------------------ */

/** 是否隐藏分页控件,默认NO */
@property (nonatomic, assign) BOOL hidesForPageControl;

/** 当总页数为1时,是否自动隐藏分页控件,默认NO */
@property (nonatomic, assign) BOOL hidesForSinglePage;

/** 分页控件距离轮播图垂直方向（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlVerticalOffset;

/** 分页控件距离轮播图水平方向（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlHorizontalOffset;

/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageIndicatorColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;

/** 其他分页控件小圆标图片 初始化设置 */
@property (nonatomic, strong) UIImage *pageIndicatorImage;

/** 分页控件位置 初始化设置 */
@property (nonatomic, assign) AICyclePageControlAlignment pageControlAlignment;

/** ---------------------- init ------------------------ */

/** 实例方法 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<AICycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<AICycleScrollViewDelegate>)delegate imageStringsGroup:(NSArray *)imageStringsGroup placeholderImage:(UIImage *)placeholderImage;

/** 图片滚到指定位置 该方法执行于设置图片数组之后 */
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
