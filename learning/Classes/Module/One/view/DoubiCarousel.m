//
//  DoubiCarousel.m
//  learning
//
//  Created by 祥伟 on 2018/6/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "DoubiCarousel.h"

#define AI_iCar_HEIGHT 150.f

#define scaleW 0.84 //宽度缩放比例
#define scaleH 0.75 //高度缩放比例

@interface DoubiCarousel ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic, strong) iCarousel *iCarouselQ;//questions
@property (nonatomic, strong) iCarousel *iCarouselA;//Answers

//当前拖动的Carousel
@property (nonatomic, strong) iCarousel *dragingCarousel;

@end

@implementation DoubiCarousel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    if (self = [super init]) {
        [self setUpSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _iCarouselQ = [[iCarousel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 10, SCREEN_WIDTH*0.8, AI_iCar_HEIGHT-20)];
        _iCarouselQ.type = iCarouselTypeCustom;
        _iCarouselQ.delegate = self;
        _iCarouselQ.dataSource = self;
        _iCarouselQ.pagingEnabled = YES;
        _iCarouselQ.scrollSpeed = 3;
        
        _iCarouselA = [[iCarousel alloc]initWithFrame:CGRectMake(0, AI_iCar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-AI_iCar_HEIGHT-AI_NavAndStatusHeight-AI_TabbarHeight)];

        _iCarouselA.type = iCarouselTypeLinear;
        _iCarouselA.delegate = self;
        _iCarouselA.dataSource = self;
        _iCarouselA.pagingEnabled = YES;

        [self addSubviews:@[_iCarouselQ,_iCarouselA]];
    });
    
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 10;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
   
    if ([carousel isEqual:_iCarouselQ]) {
        UILabel *lab = (UILabel *)view;
        if (!lab) {
            lab = [UILabel labelWithFrame:carousel.bounds textColor:AI_RGB51 font:AI_SYSTEM_Size(25) text:@"123" textAlignment:NSTextAlignmentCenter];
            lab.numberOfLines = 0;
            ViewBorderRadius(lab, 12.5, 1.0, AIRandom_color);
        }
        
        return lab;
    }else{
        UITextView *textView = (UITextView *)view;
        if (!textView) {
            textView = [[UITextView alloc]initWithFrame:carousel.bounds];
            textView.font = AI_SYSTEM_Size(20);
            textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        }
        textView.text = @"45456dsadadasdasdasdasdas456dsadadasdasdasdasdas456dsadadasdasdasdasdas456dsadadasdasdasdasdas456dsadadasdasdasdasdas6dsadadasdasdasdasdas";
        textView.backgroundColor = AIRandom_color;
        return textView;
    }
    
}


#pragma mark - iCarouselDelegate
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option){
        case iCarouselOptionWrap:  return YES;
        default:                   return value;
    }
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    
    if ([carousel isEqual:self.iCarouselA]) return transform;
    
    return CATransform3DScale(CATransform3DTranslate(transform, offset*carousel.frame.size.width, 0.0, 0.0), [self scale:scaleW ByOffset:offset], [self scale:scaleH ByOffset:offset], 1.0f);
    
}

- (CGFloat)scale:(CGFloat)scale ByOffset:(float)offset{
    float off = fabsf(offset);
    if (off <= 1) {
        return 1-(1-scale)*off;
    }
    return scale;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    _dragingCarousel = carousel;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    //不然会引起循环滚动。
    if(_dragingCarousel != carousel){
        return;
    }
    
    if(carousel == _iCarouselQ){
        _iCarouselA.scrollOffset = carousel.scrollOffset;
    }else if(carousel == _iCarouselA){
        _iCarouselQ.scrollOffset = carousel.scrollOffset;
    }
    
}

@end
