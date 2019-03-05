//
//  WeChatMeViewController.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMeViewController.h"
#import "AIBaseTableView.h"
#import "WeChatMeListModel.h"
#import "WeChatMeInfoModel.h"
#import "WeChatMeTableViewCell.h"
#import "WeChatMeTableFooterView.h"
#import "WeChatMeTableHeaderView.h"

@interface WeChatMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AIBaseTableView *tableView;

@end

@implementation WeChatMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatMeListModel class] json:WeChatMeListModel.localData]];
    
    [self.dataSource2 addObject:[WeChatMeInfoModel yy_modelWithJSON:WeChatMeInfoModel.responseObject]];
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 56;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WeChatMeListModel *model = self.dataSource[section];
    return model.item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatMeTableViewCell *cell = [WeChatMeTableViewCell initWithTableView:tableView];
    WeChatMeListModel *model = self.dataSource[indexPath.section];
    cell.meModel = model.item[indexPath.row];
    
    cell.hiddenLine = (model.item.count == indexPath.row+1) ? YES : NO;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WeChatMeTableFooterView *footer = [WeChatMeTableFooterView initWithTableView:tableView];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) return [UIView new];
    
    WeChatMeTableHeaderView *header = [WeChatMeTableHeaderView initWithTableView:tableView];
    header.infoModel = [self.dataSource2 lastObject];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? CGFLOAT_MIN : 200.f;
}

#pragma mark -- scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.tableView]) {
        NSLog(@"%lf",scrollView.contentOffset.y);
   
    }
}

@end
