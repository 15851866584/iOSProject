//
//  AISecondTabBarController.m
//  learning
//
//  Created by 祥伟 on 2018/8/3.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AISecondTabBarController.h"

@interface AISecondTabBarController ()

@end

@implementation AISecondTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setUpViewControllers{
    
    NSArray *vcs = @[@"ViewController",@"ViewController",@"ViewController"];
    NSArray *names = @[@"搬砖",@"码农",@"大神"];
    NSArray *images = @[@"small_normal",@"middle_normal",@"college_normal"];
    
    for (int i = 0; i < vcs.count; i++ ) {
        Class class = NSClassFromString(vcs[i]);
        [self setUpViewControllersInNavClass:[UINavigationController class] rootClass:class tabBarName:names[i] tabBarImageName:images[i]];
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
