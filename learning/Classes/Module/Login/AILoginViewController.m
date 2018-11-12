//
//  AILoginViewController.m
//  learning
//
//  Created by 祥伟 on 2018/7/19.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AILoginViewController.h"

@interface AILoginViewController ()

@end

@implementation AILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(100, 100, 100, 100) textColor:[UIColor whiteColor] backgroundColor:[UIColor redColor] font:UNSize20 text:@"登录页" target:self action:@selector(login)];
    [self.view addSubview:btn];

}

- (void)login{
    CloseURL(nil);
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
