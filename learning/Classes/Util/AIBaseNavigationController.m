//
//  AIBaseNavigationController.m
//  learning
//
//  Created by 祥伟 on 2018/7/5.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIBaseNavigationController.h"

@interface AIBaseNavigationController ()

@end

@implementation AIBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
#if DEBUG
    BOOL fromBase = NO;
    UIViewController *vc = viewController;
    while (vc) {
        NSString *vcString = NSStringFromClass(vc.class);
        if ([vcString containsString:@"AIBase"]) {
            fromBase = YES;
            break;
        }else{
            vc = (UIViewController *)vc.superclass;
        }
    }
    
    if (!fromBase) {
        DLog(@"警告：%@未继承AIBaseViewController",viewController.class);
    }
#endif
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    NSString *type = UDValue(@"type");
    if (type.length > 0) {
        CATransition *animation = [CATransition animation];
        //动画时间
        animation.duration = 1.0f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //过渡效果
        animation.type = type;
        //过渡方向
        animation.subtype = kCATransitionFromRight;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
