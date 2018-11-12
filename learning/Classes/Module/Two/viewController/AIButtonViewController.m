//
//  AIButtonViewController.m
//  learning
//
//  Created by 祥伟 on 2018/9/19.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIButtonViewController.h"
#import "AITextView.h"

@interface AIButtonViewController ()

@end

@implementation AIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(100, 100, 100, 100) textColor:AI_RGB255 backgroundColor:[UIColor grayColor] font:AI_SYSTEM_Size(16) text:@"按钮" image:IMG(@"ai_login") target:self action:@selector(click:)];
    [self.view addSubview:btn];

}

- (void)click:(UIButton *)sender{
    UIAlertController *alerVc = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"按钮类别" message:nil cancelTitle:@"取消" cancel:^(NSString *cancel) {
        
    } oksTitle:@[@"文字居上",@"文字居下",@"文字居左",@"文字居右",@"修改点击区域",@"修改响应间隔",@"倒计时"] ok:^(NSUInteger index) {
        switch (index) {
            case 0:
                [sender setTitlePosition:TitlePositionTop spacing:10];
                break;
            case 1:
                [sender setTitlePosition:TitlePositionBottom spacing:10];
                break;
            case 2:
                [sender setTitlePosition:TitlePositionLeft spacing:10];
                break;
            case 3:
                [sender setTitlePosition:TitlePositionRight spacing:10];
                break;
                
            case 4:
                sender.enlargedEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
                break;
                
            case 5:
                sender.timeInterval = 5;//可全局修改
                
//                [sender clickedTimeInterval:5.0];//局部修改
                break;
                
            case 6:
                //倒计时时间准确，切入后台线程会暂停需要开始后台线程任务
                [sender countDownFromTime:5 title:@"结束" unitTitle:@"s" mainColor:[UIColor grayColor] countColor:[UIColor grayColor]];
                break;
            default:
                break;
        }
    }];
    
    [self presentViewController:alerVc animated:YES completion:nil];
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
