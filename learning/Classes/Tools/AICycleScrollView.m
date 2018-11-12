//
//  AICycleScrollView.m
//  learning
//
//  Created by 祥伟 on 2018/8/8.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AICycleScrollView.h"
#import <iCarousel.h>

#define pageControlEdgeWidth 10.0f

@interface AICycleScrollView ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic, strong) UIImageView *wallPaperView;
@property (nonatomic, strong) iCarousel *iCarousel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation AICycleScrollView

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<AICycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage{
    
    return [self cycleScrollViewWithFrame:frame delegate:delegate imageStringsGroup:nil placeholderImage:placeholderImage];
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<AICycleScrollViewDelegate>)delegate imageStringsGroup:(NSArray *)imageStringsGroup placeholderImage:(UIImage *)placeholderImage{
    
    AICycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    cycleScrollView.imageStringsGroup = imageStringsGroup;
    [cycleScrollView setPageControl];
    [cycleScrollView setupTimer];
    return cycleScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self setDefaultConfig];
        [self addSubviews:
        @[self.wallPaperView,self.iCarousel,self.pageControl]];
    }
    return self;
}

//默认配置
- (void)setDefaultConfig{

    _estoppage = NO;
    _clockwise = YES;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _autoScrollTimeInterval = 2.0;
    _dragDirection = AICycleScrollViewDragHorizontal;
    
    
    _hidesForPageControl = NO;
    _hidesForSinglePage = NO;
    _pageControlAlignment = AICyclePageControlAlignmentCenter;
    _pageControlVerticalOffset = 0.0f;
    _pageControlHorizontalOffset = 0.0f;
    
}

- (void)setPageControl{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollViewCustomPageControl:)]) {
        UIView *customPageControl = [self.delegate cycleScrollViewCustomPageControl:self];
        if (customPageControl) {
            self.pageControl.hidden = YES;
            [self addSubview:customPageControl];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollViewCustomFrame:)]) {
        _iCarousel.frame = [self.delegate cycleScrollViewCustomFrame:self];
    }
}

- (void)setImageWithImageView:(UIImageView *)imageView index:(NSUInteger)index{
    if (_imageStringsGroup.count) {
        
        id obj = _imageStringsGroup[index];
        if ([obj isKindOfClass:[NSString class]]) {
            if ([obj isValidUrl]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:_placeholderImage];
            }else{
                imageView.image = IMG(obj)?:_placeholderImage;
            }
        }else if ([obj isKindOfClass:[NSURL class]]){
            [imageView sd_setImageWithURL:obj placeholderImage:_placeholderImage];
        }
        
    }else{
        imageView.image = _placeholderImage;
    }
}

#pragma mark - pageControl
- (void)updatePageControlView{
    if (_imageStringsGroup.count) {
        _pageControl.numberOfPages = _imageStringsGroup.count;
        [_pageControl sizeToFit];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIView *firstV = _pageControl.subviews[0];
            CGFloat pageControlx;
            CGFloat pageControlWidth;
 
            if (_pageControl.numberOfPages == 1) {
                pageControlWidth = VW(firstV);
            }else{
                UIView *lastV = _pageControl.subviews[_pageControl.numberOfPages-1];
                pageControlWidth = VR(lastV)-VL(firstV);
            }
            
            if (_pageControlAlignment == AICyclePageControlAlignmentLeft) {
                pageControlx = pageControlEdgeWidth;
            }else if (_pageControlAlignment == AICyclePageControlAlignmentRight){
                pageControlx = VW(self)-pageControlWidth-pageControlEdgeWidth;
            }else{
                pageControlx = (VW(self)-pageControlWidth)/2;
            }
            _pageControl.frame = CGRectMake(pageControlx+_pageControlHorizontalOffset, VH(self)-VH(_pageControl)+_pageControlVerticalOffset, pageControlWidth, VH(_pageControl));
        });

    }
}

#pragma mark - Timer
- (void)setupTimer{
    
    if (!_autoScroll) return;
    [self invalidateTimer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll{
    NSInteger index = _clockwise?_iCarousel.currentItemIndex+1:_iCarousel.currentItemIndex-1;

    if (!_infiniteLoop && (index==-1 || index == _imageStringsGroup.count)){
        [self invalidateTimer];
    }else{
        [_iCarousel scrollToItemAtIndex:index animated:YES];
    }
}

- (void)invalidateTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - dealloc
- (void)dealloc{
    _iCarousel.delegate = nil;
    _iCarousel.dataSource = nil;
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

#pragma mark - iCarouselDelegate,iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _imageStringsGroup.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UIImageView *imageView = (UIImageView *)view;
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:carousel.bounds];
        imageView.userInteractionEnabled = YES;
    }

    _wallPaperView.contentMode = imageView.contentMode = _bannerImageViewContentMode ?: UIViewContentModeScaleToFill;
    [self setImageWithImageView:imageView index:index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:addSubviewsAtIndex:)]) {
        NSArray *subViews = [self.delegate cycleScrollView:self addSubviewsAtIndex:index];
        [imageView removeAllSubView];
        if(subViews.count)[imageView addSubviews:subViews];
    }
    return imageView;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self invalidateTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
        case iCarouselOptionWrap:  return _infiniteLoop;
        default:                   return value;
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:index];
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
        [self.delegate cycleScrollView:self didScrollToIndex:carousel.currentItemIndex];
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pageControl.currentPage = carousel.currentItemIndex;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:didChangeToIndex:)]) {
        [self.delegate cycleScrollView:self didChangeToIndex:carousel.currentItemIndex];
    }
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (_estoppage && floor(self.scrollOffset) > carousel.scrollOffset) {
        carousel.scrollOffset = self.scrollOffset;
    }

    self.scrollOffset = carousel.scrollOffset;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollViewDidScroll:)]) {
        [self.delegate cycleScrollViewDidScroll:self];
    }
}

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated{
    if (_imageStringsGroup.count > index) {
        [_iCarousel scrollToItemAtIndex:index animated:animated];
    }
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    if (_dragDirection == AICycleScrollViewDragVertical) {
       return VH(carousel.currentItemView);
    }
    return VW(carousel.currentItemView);
}

#pragma  mark - setter/getter

- (void)setBounces:(BOOL)bounces{
    if (_bounces != bounces) {
        _bounces = bounces;
        _iCarousel.bounces = bounces;
    }
}

- (void)setEstoppage:(BOOL)estoppage{
    if (_estoppage != estoppage) {
        _estoppage = estoppage;
    }
}

- (void)setAutoScroll:(BOOL)autoScroll{
    if (_autoScroll != autoScroll) {
        _autoScroll = autoScroll;
        _autoScroll?[self setupTimer]:[self invalidateTimer];
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop{
    if (_infiniteLoop != infiniteLoop) {
        _infiniteLoop = infiniteLoop;
        [_iCarousel reloadData];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    if (_autoScrollTimeInterval != autoScrollTimeInterval) {
        _autoScrollTimeInterval = autoScrollTimeInterval;
        [self setupTimer];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    if (_placeholderImage != placeholderImage) {
        _placeholderImage = placeholderImage;
    }
}

- (void)setWallPaperImage:(UIImage *)wallPaperImage{
    if (_wallPaperImage != wallPaperImage) {
        _wallPaperImage = wallPaperImage;
        _wallPaperView.image = wallPaperImage;
    }
}

- (void)setImageStringsGroup:(NSArray *)imageStringsGroup{
    if (_imageStringsGroup != imageStringsGroup) {
        _imageStringsGroup = imageStringsGroup;
        
        [_iCarousel reloadData];
        [self updatePageControlView];
    }
}

- (void)setBannerImageViewContentMode:(UIViewContentMode)bannerImageViewContentMode{
    if (_bannerImageViewContentMode != bannerImageViewContentMode) {
        _bannerImageViewContentMode = bannerImageViewContentMode;
        [_iCarousel reloadData];
    }
}

- (void)setDragDirection:(AICycleScrollViewDragDirection)dragDirection{
    if (_dragDirection != dragDirection) {
        _dragDirection = dragDirection;
        _iCarousel.vertical = !dragDirection;
    }
}

- (void)setClockwise:(BOOL)clockwise{
    if (_clockwise != clockwise) {
        _clockwise = clockwise;
        [self setupTimer];
    }
}

/** ---------------------- PageControl ------------------------ */
- (void)setHidesForPageControl:(BOOL)hidesForPageControl{
    if (_hidesForPageControl != hidesForPageControl) {
        _hidesForPageControl = hidesForPageControl;
        _pageControl.hidden = hidesForPageControl;
    }
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage{
    if (_hidesForSinglePage != hidesForSinglePage) {
        _hidesForSinglePage = hidesForSinglePage;
        _pageControl.hidesForSinglePage = hidesForSinglePage;
    }
}

- (void)setPageControlAlignment:(AICyclePageControlAlignment)pageControlAlignment{
    if (_pageControlAlignment != pageControlAlignment) {
        _pageControlAlignment = pageControlAlignment;
        [self updatePageControlView];
    }
}

- (void)setPageControlVerticalOffset:(CGFloat)pageControlVerticalOffset{
    if (_pageControlVerticalOffset != pageControlVerticalOffset) {
        _pageControlVerticalOffset = pageControlVerticalOffset;
        [self updatePageControlView];
    }
}

- (void)setPageControlHorizontalOffset:(CGFloat)pageControlHorizontalOffset{
    if (_pageControlHorizontalOffset != pageControlHorizontalOffset) {
        _pageControlHorizontalOffset = pageControlHorizontalOffset;
        [self updatePageControlView];
    }
}

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor{
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorColor;
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor{
    _pageControl.pageIndicatorTintColor = pageIndicatorColor;
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage{
    [_pageControl setValue:currentPageIndicatorImage forKeyPath:@"_currentPageImage"];
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage{
    [_pageControl setValue:pageIndicatorImage forKeyPath:@"_pageImage"];
}

#pragma  mark - Lazy loading
- (UIImageView *)wallPaperView{
    if (!_wallPaperView) {
        _wallPaperView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _wallPaperView;
}

- (iCarousel *)iCarousel{
    if (!_iCarousel) {
        _iCarousel = [[iCarousel alloc]initWithFrame:self.bounds];
        _iCarousel.type = iCarouselTypeLinear;
        _iCarousel.delegate = self;
        _iCarousel.dataSource = self;
        _iCarousel.scrollEnabled = YES;
        _iCarousel.pagingEnabled = YES;
        _iCarousel.clipsToBounds = YES;
        _iCarousel.bounces = NO;
    }
    return _iCarousel;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidesForSinglePage = NO;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
@end
