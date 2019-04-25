//
//  AIAnimationViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/22.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIAnimationViewController.h"
#import "AICycleScrollView.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"
@interface AIAnimationViewController ()<AICycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation AIAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:@[@"CABasicAnimation",@"CAKeyframeAnimation",@"CATransitionAnimation",@"CGAffineTransformIdentity"]];
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    [self.view addSubview:self.tableView];
    
    _animationView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
}

/*
 *   [UIView beginAnimations:nil context:nil];
 *   [UIView commitAnimations];
 */


/*  CABasicAnimation
 *  位置 position->positionAnimation
 *  透明度 opacity->opacityAnimation
 *  缩放 bounds/transfrom.scale/transfrom.scale.x->scaleAnimation
 *  旋转 transform/transform.rotation.z->rotateAnimation
 *  背景色 backgroundColor->backgroundAnimation
 *
 */

- (void)CABasicAnimation{
    //QuartzCore CAAnimation
    
    //位移
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"position"];
    an.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    an.fillMode = kCAFillModeForwards;
    an.removedOnCompletion = NO;
    an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_animationView.layer addAnimation:an forKey:@"positionAnimation"];
    
    //透明度
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    [_animationView.layer addAnimation:anima forKey:@"opacityAniamtion"];
    
    //缩放
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.toValue = [NSNumber numberWithFloat:0.5f];
    //    [CABasicAnimation animationWithKeyPath:@"bounds"];
    //    [NSValue valueWithCGRect:CGRectMake(0, 0, 300, 300)];
    [_animationView.layer addAnimation:ani forKey:@"scaleAnimation"];
    
    //旋转
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    //    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]
    //    [NSNumber numberWithFloat:M_PI];
    [_animationView.layer addAnimation:anim forKey:@"rotateAnimation"];
    
    //背景色
    CABasicAnimation *animat = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animat.toValue = (id)[UIColor greenColor].CGColor;
    [_animationView.layer addAnimation:animat forKey:@"backgroundAnimation"];
    
//    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];

}

/*  CAKeyframeAnimation
 *  位置 position->keyFrameAnimation
 *      position->pathAnimation
 *  抖动 transform.rotation->shakeAnimation
 *
 */
- (void)CAKeyframeAnimation{
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue *value = [NSValue valueWithCGPoint:_animationView.frame.origin];
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
//    anima.values = [NSArray arrayWithObjects:value,value1,value2, nil];
//    anima.duration = 2.0f;
//    [_animationView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(150, 150, 200, 200)];
    ani.path = path.CGPath;
    ani.duration = 5;
    [_animationView.layer addAnimation:ani forKey:@"pathAnimation"];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:DegreesToRadian(0)];
    NSValue *value2 = [NSNumber numberWithFloat:DegreesToRadian(-30)];
    NSValue *value3 = [NSNumber numberWithFloat:DegreesToRadian(30)];
    anima.values = @[value1,value2,value3];
    anima.duration = 5;
    [_animationView.layer addAnimation:anima forKey:@"shakeAnimation"];
}


/*  CATransition
 *  逐渐消失  kCATransitionFade
 *  右平移    kCATransitionMoveIn
 *  push     kCATransitionPush
 *  左平移    kCATransitionReveal
 *  立体翻页  cube、suckEffect、oglFlip、rippleEffect、pageCurl、pageUnCurl、cameraIrisHollowOpen、cameraIrisHollowClose
 *
 */
- (void)CATransition{
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";
    anima.duration = 1.0f;
    [_animationView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

- (void)CGAffineTransformIdentity{
    _animationView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        _animationView.transform = CGAffineTransformTranslate(transform2, 100, 100);
        //CGAffineTransformInvert 反转
    }];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEOETableViewCell *cell = [AIEOETableViewCell initWithTableView:tableView];
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performMethod:self.dataSource[indexPath.row]];
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
