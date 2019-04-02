//
//  WeChatChatRoomInputView.m
//  learning
//
//  Created by 祥伟 on 2019/4/1.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatChatRoomInputView.h"

#define kChatRoomInputTopMargin 6.0f  //输入框上下间隙
#define kChatRoomInputLeftMargin 15.0f //输入框左右间隙
#define kChatRoomInputImageWidth 28.0f  //图片大小

#define kChatRoomInputMinHeight  37.0f
#define kChatRoomInputMaxHeight  100.0f

@implementation WeChatChatRoomInputView
{
    UIButton *_inputImageVoice;
    UITextView *_inputTextView;
    UIButton *_inputImageSmile;
    UIButton *_inputImageAdd;
    
    CGFloat _keyBoardH;//键盘弹出高度
    double _keyBoardT;//键盘弹出时间
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    self.backgroundColor = WeChatRGB246;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    CGFloat inputImageTopMargin = (kChatRoomInputMinHeight+kChatRoomInputTopMargin*2-kChatRoomInputImageWidth)/2;
    _inputImageVoice = [[UIButton alloc]initWithFrame:
                        CGRectMake(kChatRoomInputLeftMargin, inputImageTopMargin,
                                   kChatRoomInputImageWidth, kChatRoomInputImageWidth)];
    _inputTextView = [[UITextView alloc]initWithFrame:
                      CGRectMake(VR(_inputImageVoice)+kChatRoomInputLeftMargin, kChatRoomInputTopMargin,
                                 SCREEN_WIDTH-kChatRoomInputLeftMargin*5-kChatRoomInputImageWidth*3, kChatRoomInputMinHeight)];
    _inputImageSmile = [[UIButton alloc]initWithFrame:
                        CGRectMake(VR(_inputTextView)+kChatRoomInputLeftMargin, inputImageTopMargin,
                                   kChatRoomInputImageWidth, kChatRoomInputImageWidth)];
    _inputImageAdd = [[UIButton alloc]initWithFrame:
                      CGRectMake(VR(_inputImageSmile)+kChatRoomInputLeftMargin,
                                 inputImageTopMargin,
                                 kChatRoomInputImageWidth, kChatRoomInputImageWidth)];
    
    [self addSubviews:@[_inputImageVoice,_inputTextView,_inputImageSmile,_inputImageAdd]];

    [_inputImageVoice setImage:IMG(@"wechat_room_voice") forState:UIControlStateNormal];
    [_inputImageSmile setImage:IMG(@"wechat_room_smile") forState:UIControlStateNormal];
    [_inputImageAdd setImage:IMG(@"wechat_room_add") forState:UIControlStateNormal];
    
    _inputTextView.layer.cornerRadius = 4;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.tintColor = WeChatLightGreen;
    _inputTextView.font = WeChatFont16;
    _inputTextView.delegate = self;
    _inputTextView.returnKeyType = UIReturnKeyDone;
    
    [_inputImageVoice addTarget:self action:@selector(clickInputVoice:) forControlEvents:UIControlEventTouchUpInside];
    [_inputImageSmile addTarget:self action:@selector(clickInputSmile:) forControlEvents:UIControlEventTouchUpInside];
    [_inputImageAdd addTarget:self action:@selector(clickInputAdd:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickInputVoice:(UIButton *)sender{
    
}

- (void)clickInputSmile:(UIButton *)sender{
  
}

- (void)clickInputAdd:(UIButton *)sender{
   
}

- (void)show{
    if (![_inputTextView isFirstResponder]) {
        [_inputTextView becomeFirstResponder];
    }
}

- (void)hidden{
    if ([_inputTextView isFirstResponder]) {
        [_inputTextView resignFirstResponder];
    }
}

#pragma mark - UIKeyboardWillShowNotification
- (void)keyboardWillShow:(NSNotification *)aNotification{

    NSDictionary *info = [aNotification userInfo];
    CGSize kSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    //处理重复调用问题
    if (_keyBoardH != kSize.height) {
        
        _keyBoardT = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if (_keyBoardH == 0) {
            _keyBoardH = kSize.height;
            [self autoLayoutInputView:VH(_inputTextView) changeH:_keyBoardH-AI_TabbarSafeHeight];
        }else{
            [self autoLayoutInputView:VH(_inputTextView) changeH:kSize.height-_keyBoardH];
            _keyBoardH = kSize.height;
        }
    }
}

- (void)keyboardWillHidden:(NSNotification *)aNotification{

    if (_keyBoardH) {
        [self autoLayoutInputView:NO];
    }
}


#pragma mark --UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    [self getTextViewHeight];
}

- (void)getTextViewHeight{
    UITextView *textView = _inputTextView;
    CGFloat oldTextHeight = VH(textView);
    
    //计算文本高度，输入框自适应高度
    CGFloat textHeight = [UITextView getTextViewHeightWithText:textView.text font:textView.font width:textView.width];
    
    if (textHeight < kChatRoomInputMinHeight) {
        textHeight = kChatRoomInputMinHeight;
        textView.scrollEnabled = NO;
    }else if (textHeight > kChatRoomInputMaxHeight){
        textHeight = kChatRoomInputMaxHeight;
        textView.scrollEnabled = YES;
    }
    
    if (textHeight != oldTextHeight) {
        [self autoLayoutInputView:textHeight changeH:textHeight-oldTextHeight];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        if (self.didSelectFinishBlock) {
            self.didSelectFinishBlock(textView.text);
            textView.text = @"";
            [self getTextViewHeight];
        }
        return NO;
    }
    
    return YES;
    
}

//键盘出现，高度变化
- (void)autoLayoutInputView:(CGFloat)textHeight changeH:(CGFloat)changH{
    
    //tableView滚到底部
    UITableView *tableView = [self getTableView];

    [UIView animateWithDuration:_keyBoardT animations:^{
        //变化高度值
        tableView.frame = CGRectMake(VL(tableView), VT(tableView), VW(tableView), VH(tableView)-changH);
        if ([tableView numberOfRowsInSection:0]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([tableView numberOfRowsInSection:0]-1) inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        self.frame = CGRectMake(VL(self), VB(tableView), VW(self), textHeight+kChatRoomInputTopMargin*2);
        
        CGFloat inputImageY = textHeight+kChatRoomInputTopMargin-(kChatRoomInputImageWidth+kChatRoomInputMinHeight)/2;
        _inputImageVoice.frame = CGRectMake(kChatRoomInputLeftMargin, inputImageY, kChatRoomInputImageWidth, kChatRoomInputImageWidth);
        _inputTextView.frame = CGRectMake(VR(_inputImageVoice)+kChatRoomInputLeftMargin, kChatRoomInputTopMargin, _inputTextView.width, textHeight);
        _inputImageSmile.frame = CGRectMake(VR(_inputTextView)+kChatRoomInputLeftMargin, inputImageY, kChatRoomInputImageWidth, kChatRoomInputImageWidth);
        _inputImageAdd.frame = CGRectMake(VR(_inputImageSmile)+kChatRoomInputLeftMargin, inputImageY, kChatRoomInputImageWidth, kChatRoomInputImageWidth);
    }];
    
}

//键盘消失
- (void)autoLayoutInputView:(BOOL)isVoice{
    
    UITableView *tableView = [self getTableView];
    
    [UIView animateWithDuration:_keyBoardT animations:^{
        //变化高度值
        tableView.frame = CGRectMake(VL(tableView), VT(tableView), VW(tableView), VH(tableView)+_keyBoardH-AI_TabbarSafeHeight);
        if ([tableView numberOfRowsInSection:0]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([tableView numberOfRowsInSection:0]-1) inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        self.frame = CGRectMake(VL(self), VB(tableView), VW(self), VH(tableView));
        
    } completion:^(BOOL finished) {
        _keyBoardH = 0;
    }];
}

- (UITableView *)getTableView{
    UITableView *tableView = nil;
    UIView *supview = self.superview;
    for (UIView *v in supview.subviews) {
        if ([v isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)v;
        }
    }
    return tableView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
