//
//  AIHUDViewController.m
//  learning
//
//  Created by 祥伟 on 2018/8/23.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIHUDViewController.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"

@interface AIHUDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AIBaseTableView *tableView;
@end

@implementation AIHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubViews];
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:@[@"菊花",@"文字",@"图片",@"图文",@"动图",@"自定义"]];
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    [self.view addSubview:self.tableView];

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
    
    switch (indexPath.row) {
        case 0:
            [self HUD:@"菊花" type:HUDLoadingIndicator];
            break;
        case 1:
            [self text:@"仅展示文字"];
            break;
        case 2:
            [self icon:@"face"];
            break;
        case 3:
            [self HUD:@"图片和文字" icon:@"face"];
            break;
        case 4:{
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger i = 0; i < 12; i++) {
                [array addObject:[NSString stringWithFormat:@"icon_loading_pull_%zd",i+1]];
            }
            [self HUD:@"动态图组" images:array];
            break;
        }
        case 5:
            [self HUD:@"自定义动画" type:HUDLoadingAround];
            break;
        default:
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUDs];
    });
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
