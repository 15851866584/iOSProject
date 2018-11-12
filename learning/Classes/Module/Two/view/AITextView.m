//
//  AITextView.m
//  learning
//
//  Created by 祥伟 on 2018/9/10.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AITextView.h"

#define ObserveValue @"textColorNew"

@interface AITextView ()

@property (nonatomic, strong) NSMutableAttributedString *content;
@property (nonatomic, strong) NSMutableArray *selectionRects;

@end

@implementation AITextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        self.selectable = NO;
    }
    return self;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    self.content = [[NSMutableAttributedString alloc] initWithString:text];
    
    if (self.textColor){
        [self.content addAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, text.length)];
    }
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    
    if (self.text.length > 0) {
        [self.content addAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
    }
}

- (void)setLinkTextWithRange:(NSRange)linkTextRange withLinkColor:(UIColor *)color withBlock:(clickTextViewPartBlock)block{
    if (linkTextRange.location+linkTextRange.length > self.text.length > 0) return;
    
    [self.content addAttribute:NSForegroundColorAttributeName value:color?:[UIColor blackColor] range:linkTextRange];
    self.attributedText = self.content;
    self.selectedRange = linkTextRange;
    NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
    self.selectedRange = NSMakeRange(0, 0);
    
    NSString *linkString = [self.text substringWithRange:linkTextRange];
    NSDictionary *param = @{@"rect":selectionRects.firstObject,
                            @"linkString":linkString,
                            @"block":block
                            };
    
    [self.selectionRects addObject:param];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (NSDictionary *dic in self.selectionRects) {
        UITextSelectionRect *selectionRect = dic[@"rect"];
        NSString *linkString = dic[@"linkString"];
        clickTextViewPartBlock block = dic[@"block"];
        CGRect rect = selectionRect.rect;
        
        if (CGRectContainsPoint(rect, point)) {
            block(linkString);
            return;
        }
    }
}

- (NSMutableArray *)selectionRects{
    if (!_selectionRects) {
        _selectionRects = [NSMutableArray array];
    }
    return _selectionRects;
}

@end
