//
//  WeChatNavigationController.m
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatNavigationController.h"

@interface WeChatNavigationController ()

@end

@implementation WeChatNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:WeChatRGB241] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];

    [self.navigationBar setTitleTextAttributes:
  @{NSForegroundColorAttributeName:WeChatRGB0,
               NSFontAttributeName:WeChatFont20}];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
