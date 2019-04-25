//
//  AIPreViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIPreViewController.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"
#import "AILoginViewController.h"

//测试,路由+传参+MVVM
#import "DeviceModel.h"

@interface AIPreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AIBaseTableView *tableView;

@end

@implementation AIPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实例";
    [self.dataSource addObjectsFromArray:@[
     @{@"动画":@"AIAnimationViewController"},
     @{@"绘图":@"AIDrawViewController"},
     @{@"悬浮视图":@"AIDragViewController"},
     @{@"滚动视图":@"AICycleScrollViewController"},
     @{@"HUD":@"AIHUDViewController"},
     @{@"SpringHeader":@"AISpringHeaderVC"},
     @{@"按钮":@"AIButtonViewController"},
     @{@"布局":@"AILayoutViewController"},
     @{@"简书":@"AIWebViewController"},
     @{@"传参":@"AIMVVMViewController"},
     @{@"html高度":@"AIGetHeightViewController"},
     @{@"页面跳转动画":@"AIPageAnimationViewController"}]];
    
    [self setUpSubViews];
  
}


- (void)setUpSubViews{
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    [self.view addSubview:self.tableView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEOETableViewCell *cell = [AIEOETableViewCell initWithTableView:tableView];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.title = [[dic allKeys] firstObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *urlString = [[dic allValues] firstObject];
    OpenURLp(urlString,@{@"deviceInfo":[DeviceModel getDeviceInfo]});
}

@end
