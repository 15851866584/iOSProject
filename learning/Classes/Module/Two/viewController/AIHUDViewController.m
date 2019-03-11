//
//  AIHUDViewController.m
//  learning
//
//  Created by 祥伟 on 2018/8/23.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIHUDViewController.h"

@interface AIHUDViewController ()

@end

@implementation AIHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAlert];
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideHUDs];
    [self showAlert];
    
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"HUD" message:@"MBProgress扩展" cancelTitle:@"取消" cancel:^(NSString *cancel) {
        
    } oksTitle:@[@"菊花",@"文字",@"图片",@"图文",@"动图",@"自定义"] ok:^(NSUInteger index) {
        switch (index) {
            case 0:
                [self HUD:@"菊花" type:HUDLoadingIndicator];
                break;
            case 1:
                [self text:@"仅展示文字"];
                break;
            case 2:
                [self icon:@"face"];
                break;
            case 3:
                [self HUD:@"图片和文字" icon:@"face"];
                break;
            case 4:{
                NSMutableArray *array = [NSMutableArray array];
                for (NSInteger i = 0; i < 12; i++) {
                    [array addObject:[NSString stringWithFormat:@"icon_loading_pull_%zd",i+1]];
                }
                [self HUD:@"动态图组" images:array];
                break;
            }
            case 5:
                [self HUD:@"自定义动画" type:HUDLoadingAround];
                break;
            default:
                break;
        }
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
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
