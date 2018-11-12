//
//  AIDrawViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/28.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIDrawViewController.h"
#import "AIDrawView.h"

@interface AIDrawViewController ()
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) CAGradientLayer *dcGradientLayer;
@end

@implementation AIDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AIDrawView *drawV = [AIDrawView viewWithFrame:self.view.bounds backgroundColor:[UIColor grayColor]];
    [self.view addSubview:drawV];
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
