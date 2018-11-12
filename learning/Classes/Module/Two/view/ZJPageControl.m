//
//  ZJPageControl.m
//  ZJPageControl
//
//  Created by Evan on 7/9/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ZJPageControl.h"

static const CGFloat kZJPageControlDefaultLineWidth = 2.0f;
static const CGFloat kZJPageControlDefaultRadius = 10.0f;
static const CGFloat kZJPageControlDefaultPadding = 20.0f;
static const CGFloat kZJPageControlDefaultMargin = 20.0f;
static const CGFloat kZJPageControlDefaultAnimationDuration = 0.3f;

#define kZJPageControlDefaultPageIndicatorTintColor [UIColor colorWithWhite:1 alpha:0.6]
#define kZJPageControlDefaultCurrentPageIndicatorTintColor [UIColor whiteColor]

@interface ZJPageControl()<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) NSInteger lastPage;
@end

@implementation ZJPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _lineWidth = kZJPageControlDefaultLineWidth;
    _radius = kZJPageControlDefaultRadius;
    _padding = kZJPageControlDefaultPadding;
    _margin = kZJPageControlDefaultMargin;
    
    _lastPage = 0;
    _numberOfPages = 0;
    _currentPage = 0;
    
    _pageIndicatorTintColor = kZJPageControlDefaultPageIndicatorTintColor;
    _currentPageIndicatorTintColor = kZJPageControlDefaultCurrentPageIndicatorTintColor;
    
    [self.layer addSublayer:self.shapeLayer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)drawRect:(CGRect)rect {
    if ((self.numberOfPages <= 1 && self.hidesForSinglePage) || self.numberOfPages == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < self.numberOfPages; i++) {
        CGPoint circleCenter = [self _centerOfCircleAtPage:i];
        CGContextSetStrokeColorWithColor(context, self.pageIndicatorTintColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, circleCenter.x, circleCenter.y, self.radius, 0, M_PI * 2, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    [self _moveToPageWithAnimated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.shapeLayer.frame = self.bounds;
    [self setNeedsDisplay];
}

#pragma mark - Event Response

- (void)onTapped:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    BOOL hasPageChanged = NO;
    if (touchPoint.x < CGRectGetWidth(self.frame) / 2 ) {
        // move left
        if (self.currentPage > 0) {
            self.currentPage--;
            hasPageChanged = YES;
        }
    } else {
        // move right
        if (self.currentPage < self.numberOfPages - 1) {
            self.currentPage++;
            hasPageChanged = YES;
        }
    }
    
    if (hasPageChanged) {
        [self _moveToPageWithAnimated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Private Methods

- (void)_moveToPageWithAnimated:(BOOL)animated {
    self.shapeLayer.path = [self _pathWithAnimated:animated];
    if (animated) {
        long pageNumber = labs(self.currentPage - self.lastPage);
        CGFloat linePathLength = (self.radius * 2 + self.padding) * pageNumber;
        
        CGFloat circlePathLength = M_PI * 2 * self.radius;
        CGFloat totalPathLength = circlePathLength * 2 + linePathLength;
        CGFloat strokeEnd = circlePathLength / totalPathLength;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @(0);
        strokeStartAnimation.toValue = @(1 - strokeEnd);
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @(strokeEnd);
        strokeEndAnimation.toValue = @(1);
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[strokeStartAnimation,strokeEndAnimation];
        animationGroup.duration = kZJPageControlDefaultAnimationDuration;
        animationGroup.delegate = self;
        [self.shapeLayer addAnimation:animationGroup forKey:@"StrokeAnimation"];
    }
}

- (CGPathRef)_pathWithAnimated:(BOOL)animated {
    if ((self.numberOfPages <= 1 && self.hidesForSinglePage) || self.numberOfPages == 0) {
        return nil;
    }
    
    BOOL clockwise = self.lastPage > self.currentPage;
    
    CGFloat startAngle = M_PI / 2;
    CGFloat endAngle;
    if (clockwise) {
        endAngle = startAngle + M_PI * 2;
    } else {
        endAngle = startAngle - M_PI * 2;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (animated) {
        // last circle
        CGPoint lastCircleCenter = [self _centerOfCircleAtPage:self.lastPage];
        [path addArcWithCenter:lastCircleCenter radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        
        // Line
        CGFloat lineWidth = (self.radius * 2 + self.padding) * (self.currentPage - self.lastPage);
        [path moveToPoint:CGPointMake(lastCircleCenter.x, lastCircleCenter.y + self.radius)];
        [path addLineToPoint:CGPointMake(lastCircleCenter.x + lineWidth, lastCircleCenter.y + self.radius)];
    }
    
    // current circle
    CGPoint currentCircleCenter = [self _centerOfCircleAtPage:self.currentPage];
    [path addArcWithCenter:currentCircleCenter radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    return path.CGPath;
}

- (CGPoint)_centerOfCircleAtPage:(NSInteger)page {
    CGFloat minX;
    if (self.contentMode == UIViewContentModeLeft) {
        minX = self.margin;
    } else if (self.contentMode == UIViewContentModeRight) {
        minX = self.frame.size.width - [self _totalPageIndicatorWidth] - self.margin;
    } else {
        minX = (CGRectGetWidth(self.frame) - [self _totalPageIndicatorWidth]) / 2;
    }
    CGFloat midX = minX + (self.radius * 2 + self.padding) * page + self.radius;
    CGPoint center = CGPointMake(midX, CGRectGetHeight(self.frame) / 2);
    return center;
}

- (CGFloat)_totalPageIndicatorWidth {
    CGFloat width = (self.radius * 2 + self.padding) * self.numberOfPages - self.padding;
    return width;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self _moveToPageWithAnimated:NO];
    }
}

#pragma mark - Getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.lineWidth = _lineWidth;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = _currentPageIndicatorTintColor.CGColor;
    }
    return _shapeLayer;
}

#pragma mark - Setter

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self setNeedsDisplay];
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    if (self.contentMode == UIViewContentModeLeft || self.contentMode == UIViewContentModeRight) {
        [self setNeedsDisplay];
    }
}

- (void)setMargin:(CGFloat)margin {
    _margin = margin;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (numberOfPages < 0) {
        return;
    }
    _numberOfPages = numberOfPages;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [self setCurrentPage:currentPage animated:NO];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setNeedsDisplay];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.shapeLayer.strokeColor = currentPageIndicatorTintColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
    [self setNeedsDisplay];
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    [self setNeedsDisplay];
}

#pragma mark - Public Methods

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    if (currentPage < 0 || currentPage > self.numberOfPages - 1 || currentPage == _currentPage) {
        return;
    }
    _lastPage = _currentPage;
    _currentPage = currentPage;
    [self _moveToPageWithAnimated:animated];
}

@end
