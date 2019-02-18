//
//  WeChatHomeViewController.m
//  learning
//
//  Created by 祥伟 on 2019/1/24.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatHomeViewController.h"
#import "AIBaseTableView.h"
#import "WeChatMessageListModel.h"
#import "WeChatHomeTableViewCell.h"
#import "WeChatHomeMenuView.h"
#import "UITabBarItem+WZLBadge.h"
#import "WeChatSearchController.h"
#import "WeChatSearchResultController.h"
@interface WeChatHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) WeChatHomeMenuView *menuView;

@property (nonatomic, strong) WeChatSearchController *searchController;

@end

@implementation WeChatHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"微信";
    //实际开发中：首页的逻辑比较复杂
    [self setUpSubViews];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews containsObject:_menuView]) {
        [self.menuView removeFromSuperview];
    }
    
}

- (void)setUpSubViews{
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatMessageListModel class] json:WeChatMessageListModel.responseObject]];
   
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = self.view.backgroundColor;

    [self.view addSubview:self.tableView];
    [self tabBarBadgeCount];
  
    [self setSearchController];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:OrgIMG(@"wechat_menu") style:(UIBarButtonItemStylePlain) target:self action:@selector(homeMenu)];

    
}

//搜索页
- (void)setSearchController{

    self.searchController = [WeChatSearchController initSearchController];
  
    self.searchController.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.placeholder = @"搜索";
    //背景色
    searchBar.barTintColor = WeChatRGB241;
    //去掉边线
    [searchBar setBackgroundImage:[UIImage new]];
}

- (void)tabBarBadgeCount{
    NSInteger badgeCount = 0;
    for (WeChatMessageListModel *model in self.dataSource) {
        if (model.unreadCount && !model.silent) {
            badgeCount += model.unreadCount;
        }
    }
    UITabBarItem *firstItem = self.tabBarController.tabBar.items.firstObject;
    [firstItem showBadgeWithStyle:WBadgeStyleNumber value:badgeCount animationType:WBadgeAnimTypeNone];
}

//菜单
- (void)homeMenu{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews containsObject:self.menuView]) {
        [self.menuView removeFromSuperview];
    }else{
        [window addSubview:self.menuView];
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatHomeTableViewCell *cell = [WeChatHomeTableViewCell initWithTableView:tableView];
    cell.messageListModel = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

//侧滑使用系统和微信优点却别，有兴趣的小伙伴可以去自己写个demo
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        [self tabBarBadgeCount];
    }];
    
    
    WeChatMessageListModel *model = self.dataSource[indexPath.row];
    NSString *titleEdit = model.unreadCount?@"编辑已读":@"编辑未读";
  
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:titleEdit handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        model.unreadCount = model.unreadCount?0:1;
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self tabBarBadgeCount];
    }];
    
    return @[deleteAction,editAction];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    
    self.tabBarController.tabBar.hidden = YES;
    [searchController.searchResultsController becomeFirstResponder];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
  
    self.tabBarController.tabBar.hidden = NO;
    [searchController.searchResultsController resignFirstResponder];
    
}

#pragma mark - setter/getter

- (WeChatHomeMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[WeChatHomeMenuView alloc]init];
    }
    return _menuView;
}

@end
