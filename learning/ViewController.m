//
//  ViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/11.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign)UIImageView *scratchedImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMG(@"ai_left_back") style:(UIBarButtonItemStyleDone) target:self action:@selector(backUpViewController)];
    
    self.view.backgroundColor = AIRandom_color;
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 274, 145)];
    showLabel.center = self.view.center;
    showLabel.backgroundColor = [UIColor redColor];
    showLabel.textColor = [UIColor yellowColor];
    showLabel.text = @"恭喜你中奖了";
    showLabel.font = [UIFont systemFontOfSize:30];
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    
    UIImageView *scratchedImg = [[UIImageView alloc] initWithFrame:showLabel.frame];
    scratchedImg.image = [UIImage createImageWithColor:[UIColor grayColor]];
    [self.view addSubview:scratchedImg];
    self.scratchedImg = scratchedImg;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.fd_prefersNavigationBarHidden = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    return self.navigationController.childViewControllers.count-1;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.scratchedImg];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 40, 40);
    // 默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.scratchedImg.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.scratchedImg.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    
    self.scratchedImg.image = image;
}


- (void)backUpViewController{
    CloseVCURL(nil, self.tabBarController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
