//
//  WeChatChatRoomInputView.h
//  learning
//
//  Created by 祥伟 on 2019/4/1.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeChatChatRoomInputView : UIView<UITextViewDelegate>

@property (nonatomic, copy) void (^didSelectFinishBlock)(NSString *text);

- (void)show;

- (void)hidden;

@end

NS_ASSUME_NONNULL_END
