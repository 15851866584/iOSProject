//
//  WeChatDiscoverViewController.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatDiscoverViewController.h"
#import "AIBaseTableView.h"
#import "WeChatDiscoverListModel.h"
#import "WeChatDiscoverTableViewCell.h"
#import "WeChatDiscoverTableFooterView.h"

@interface WeChatDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AIBaseTableView *tableView;
@end

@implementation WeChatDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
   
    [self setUpSubViews];
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatDiscoverListModel class] json:WeChatDiscoverListModel.localData]];
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];

}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WeChatDiscoverListModel *model = self.dataSource[section];
    return model.item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatDiscoverTableViewCell *cell = [WeChatDiscoverTableViewCell initWithTableView:tableView];
    WeChatDiscoverListModel *model = self.dataSource[indexPath.section];
    cell.discoverModel = model.item[indexPath.row];

    cell.hiddenLine = (model.item.count == indexPath.row+1) ? YES : NO;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WeChatDiscoverTableFooterView *footer = [WeChatDiscoverTableFooterView initWithTableView:tableView];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


@end
