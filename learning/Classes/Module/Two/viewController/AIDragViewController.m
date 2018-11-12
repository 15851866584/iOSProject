//
//  AIDragViewController.m
//  learning
//
//  Created by 祥伟 on 2018/8/15.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIDragViewController.h"

@interface AIDragViewController ()

@end

@implementation AIDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(VW(self.view)*0.1, VH(self.view)*0.1, VW(self.view)*0.8, VH(self.view)*0.7)];
    [self.view addSubview:box];
    
    UILabel *drag2 = [UILabel labelWithFrame:CGRectMake(50, 50, 60, 30) textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] text:@"拖拽lab" textAlignment:NSTextAlignmentCenter];
    drag2.isDragable = YES;
    drag2.backgroundColor = [UIColor redColor];
    [box addSubview:drag2];
    
    UIButton *drag3 = [UIButton buttonWithFrame:CGRectMake(150, 50, 60, 30) textColor:[UIColor blackColor] backgroundColor:[UIColor yellowColor] font:[UIFont systemFontOfSize:14] text:@"拖拽btn" target:nil action:nil];
    drag3.isDragable = YES;
    [box addSubview:drag3];
    
  
    @weakify(drag2)
    [drag2 addActionWithBlock:^{
         @strongify(drag2)
        NSLog(@"%@",[drag2 class]);
    }];
    
    @weakify(drag3)
    [drag3 addActionWithBlock:^{
        @strongify(drag3)
        NSLog(@"%@",[drag3 class]);
    }];
  
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
