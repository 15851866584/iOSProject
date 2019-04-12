//
//  WeChatFriendsCircleViewController.m
//  learning
//
//  Created by 祥伟 on 2019/4/8.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatFriendsCircleViewController.h"
#import "AIBaseTableView.h"
#import "WeChatFriendsCircleTableViewCell.h"
#import "WeChatFriendsCircleHeaderFooterView.h"
#import "WeChatFriendsCircleModel.h"

@interface WeChatFriendsCircleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation WeChatFriendsCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatFriendsCircleModel class] json:WeChatFriendsCircleModel.localData]];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, AI_statusBarHeight, 44, 44)];
    [backBtn setImage:IMG(@"ai_left_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    self.backBtn = backBtn;
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, -AI_NavAndStatusHeight, SCREEN_WIDTH, SCREEN_HEIGHT+AI_NavAndStatusHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    
}

- (void)clickBackBtnEvent{
    CloseURL(nil);
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatFriendsCircleTableViewCell *cell = [WeChatFriendsCircleTableViewCell initWithTableView:tableView];

    
    cell.fcModel = self.dataSource[indexPath.row];
    
    @weakify(self)
    [cell setDidSelectLinkBlock:^(NSString * _Nonnull link, CFClickMessageType type) {
        @strongify(self)

        if (type == CFClickMessageTypeURL) {
            NSString *urlString = [NSString stringWithFormat:@"AIWebViewController?url=%@",link];
            OpenURL(urlString);
        }else if (type == CFClickMessageTypeEmail){
            [self text:@"这个可能是邮箱"];
        }else if (type == CFClickMessageTypePhoneNumber){
            [self text:@"这个可能是电话"];
        }else if (type == CFClickMessageTypeButton){
            WeChatFriendsCircleModel *model = self.dataSource[indexPath.row];
            model.open = [link integerValue];
            [self.tableView reloadData];
        }
    }];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeChatFriendsCircleHeaderFooterView *header = [WeChatFriendsCircleHeaderFooterView initWithTableView:tableView];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_HEIGHT*0.44+60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [self.tableView cellHeightForIndexPath:indexPath model:self.dataSource[indexPath.row] keyPath:@"fcModel" cellClass:[WeChatFriendsCircleTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

@end
