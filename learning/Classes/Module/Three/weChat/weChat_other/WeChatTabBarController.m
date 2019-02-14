//
//  WeChatTabBarController.m
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatTabBarController.h"
#import "WeChatNavigationController.h"

@interface WeChatTabBarController ()

@end

@implementation WeChatTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundImage = [UIImage createImageWithColor:WeChatRGB234];
    self.tabBar.shadowImage = [UIImage new];
}

- (void)setUpViewControllers{
    NSArray *vcs = @[@"WeChatHomeViewController",@"WeChatContactViewController",@"WeChatDiscoverViewController",@"WeChatMeViewController"];
    NSArray *names = @[@"微信",@"通讯录",@"发现",@"我"];
    NSArray *images = @[@"mainframe_normal",@"contacts_normal",@"discover_normal",@"me_normal"];
    
    for (int i = 0; i < vcs.count; i++ ) {
        Class class = NSClassFromString(vcs[i]);
        [self setUpViewControllersInNavClass:[WeChatNavigationController class] rootClass:class tabBarName:names[i] tabBarImageName:images[i] size:WeChatFont10  color:WeChatRGB20 selColor:WeChatBlue];
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
