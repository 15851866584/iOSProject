//
//  AIMVVMViewController.m
//  learning
//
//  Created by 祥伟 on 2018/12/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIMVVMViewController.h"
#import "AIMVVMViewModel.h"

@interface AIMVVMViewController ()
@property (nonatomic ,strong) AIMVVMViewModel *viewModel;
@end

@implementation AIMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[AIMVVMViewModel alloc]initWithViewController:self];

}

- (void)dealloc{
    NSLog(@"%s",__func__);
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
