//
//  AIPageAnimationViewController.m
//  learning
//
//  Created by 祥伟 on 2019/3/11.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIPageAnimationViewController.h"

@interface AIPageAnimationViewController ()

@end

@implementation AIPageAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置页面动画之后去其他页面看看效果
    [self setPageAnimation];
}

- (void)setPageAnimation{
    NSArray *oks = @[@"淡出效果",@"新视图移动到旧视图上",@"新视图推出旧视图",@"移开就是图显示新视图",@"立方体翻转效果",@"翻转效果",@"向上翻页效果",@"向下翻页效果",@"收缩效果",@"水滴波纹效果",@"摄像头打开效果",@"摄像头关闭效果"];
    UIAlertController *vc = [UIAlertController alertStyle:0 title:@"页面跳转动画" message:nil cancelTitle:@"取消动画" cancel:^(NSString *cancel) {
        UDRemove(@"type");
    } oksTitle:oks ok:^(NSUInteger index) {
        NSString *type = @"";
        switch (index) {
            case 0:
                type = @"fade";
                break;
            case 1:
                type = @"movein";
                break;
            case 2:
                type = @"push";
                break;
            case 3:
                type = @"reveal";
                break;
            case 4:
                type = @"cube";
                break;
            case 5:
                type = @"olgFlip";
                break;
            case 6:
                type = @"pageCurl";
                break;
            case 7:
                type = @"pageUnCurl";
                break;
            case 8:
                type = @"suckEffect";
                break;
            case 9:
                type = @"rippleEffect";
                break;
            case 10:
                type = @"cameraIrisHollowOpen";
                break;
            case 11:
                type = @"cameraIrisHollowClose";
                break;
            default:
                break;
        }
        
        UDSave(type,@"type");
    }];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self setPageAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
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
