//
//  WeChatChatRoomViewController.m
//  learning
//
//  Created by 祥伟 on 2019/3/25.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatChatRoomViewController.h"

@interface WeChatChatRoomViewController ()

@end

@implementation WeChatChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.weChatName;
    
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItems.firstObject;
    
    if (_badgeCount) {
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIButton *customBtn = [[UIButton alloc]initWithFrame:CGRectMake(-11, 11, 20, 20)];
        customBtn.backgroundColor = WeChatRGB214;
        customBtn.enabled = NO;
        customBtn.layer.cornerRadius = 10;
        customBtn.layer.masksToBounds = YES;
        customBtn.titleLabel.font = WeChatFont14;
        [customBtn setTitleColor:WeChatRGB20 forState:UIControlStateNormal];
        NSString *beginCount = [NSString stringWithFormat:@"%ld",self.badgeCount];
        [customBtn setTitle:beginCount forState:UIControlStateNormal];
        [customView addSubview:customBtn];
        UIBarButtonItem *countItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
        
        
        self.navigationItem.leftBarButtonItems = @[backItem,countItem];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_badgeCount > _unreadCount) {
                NSString *endCount = [NSString stringWithFormat:@"%ld",self.badgeCount-self.unreadCount];
                [customBtn setTitle:endCount forState:UIControlStateNormal];
            }else{
                self.navigationItem.leftBarButtonItems = @[backItem];
            }
            
        });
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
