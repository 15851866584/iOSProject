//
//  AIBaseViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIBaseViewController.h"
#import "AppDelegate.h"

#define afterDelay 2.0

@interface AIBaseViewController ()

@end

@implementation AIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMG(@"ai_left_back") style:(UIBarButtonItemStyleDone) target:self action:@selector(backUpViewController)];
         self.navigationItem.leftBarButtonItem.tintColor = AI_RGB51;
    }

    
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)backUpViewController{
    CloseURL(nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self hideHUDs];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MBProgressHUD

- (void)text:(NSString *)text{
    [self HUD:text icon:nil];
}

- (void)icon:(NSString *)icon{
    [self HUD:nil icon:icon];
}

- (void)HUD:(NSString *)text icon:(NSString *)icon{
    MBProgressHUD *hud = [MBProgressHUD showHUD:text icon:icon view:self.view];
    [hud hideDelay:afterDelay];
}

- (void)HUD:(NSString *)text images:(NSArray *)images{
    [MBProgressHUD showHUD:text images:images view:self.view];
}

- (void)HUD:(NSString *)text type:(HUDLoadingType)type{
    [MBProgressHUD showHUD:text loadingType:type view:self.view];
}

- (void)hideHUDs{
    [MBProgressHUD hide:self.view];
}


#pragma mark - dataSource

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)dataSource2{
    if (!_dataSource2) {
        _dataSource2 = [NSMutableArray array];
    }
    return _dataSource2;
}

- (NSMutableArray *)dataSource3{
    if (!_dataSource3) {
        _dataSource3 = [NSMutableArray array];
    }
    return _dataSource3;
}

@end
