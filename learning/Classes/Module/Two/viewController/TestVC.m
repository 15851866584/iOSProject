//
//  TestVC.m
//  learning
//
//  Created by 祥伟 on 2018/10/17.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *v = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
//    anim.duration = 3;
//    anim.timeOffset = 2;
//    anim.speed = 0.5;
//    anim.beginTime = CACurrentMediaTime()+2;
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(150, 450)];
//    [v.layer addAnimation:anim forKey:@"123"];
 
    [v setImage:IMG(@"guid01") forState:0];

    v.layer.masksToBounds = YES;
    v.layer.cornerRadius = 50;

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
