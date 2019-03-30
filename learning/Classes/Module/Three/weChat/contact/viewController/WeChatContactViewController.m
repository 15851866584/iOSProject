//
//  WeChatContactViewController.m
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatContactViewController.h"
#import "AIBaseTableView.h"
#import "WeChatContactListModel.h"
#import "WeChatContactTableViewCell.h"
#import "BMChineseSort.h"
#import "WeChatContactTableViewHeaderFooterView.h"
#import "WeChatSearchController.h"

@interface WeChatContactViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
@property (nonatomic, strong) AIBaseTableView *tableView;

@property (nonatomic, strong) WeChatSearchController *searchController;

@end

@implementation WeChatContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    
    BMChineseSortSetting.share.specialCharPositionIsFront = NO;
    BMChineseSortSetting.share.logEable = NO;
    [BMChineseSort sortAndGroup:WeChatContactListModel.responseObject key:@"name" finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            
            
            NSMutableArray *result = [NSMutableArray arrayWithArray:WeChatContactListModel.localData];
            for (int i = 0; i < sectionTitleArr.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:sortedObjArr[i] forKey:@"contact"];
                [dic setValue:sectionTitleArr[i] forKey:@"letter"];
                [result addObject:dic];
            }
            
            [self.dataSource removeAllObjects];
            [self.dataSource2 removeAllObjects];
            [self.dataSource2 addObjectsFromArray:sectionTitleArr];
            [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatContactListModel class] json:result]];
            [self.tableView reloadData];
        }
    }];
    
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:self.tableView];
    [self setSearchController];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:OrgIMG(@"wechat_contact") style:(UIBarButtonItemStylePlain) target:self action:@selector(contactNewfriend)];
}

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

- (void)contactNewfriend{
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WeChatContactListModel *model = self.dataSource[section];
    return model.contact.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatContactTableViewCell *cell = [WeChatContactTableViewCell initWithTableView:tableView];
    WeChatContactListModel *model = self.dataSource[indexPath.section];
    cell.contactModel = model.contact[indexPath.row];

    cell.hiddenLine = (model.contact.count == indexPath.row+1) ? YES : NO;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) {
        WeChatContactTableViewHeaderFooterView *header = [WeChatContactTableViewHeaderFooterView initWithTableView:tableView];
        header.letter = self.dataSource2[section-1];
        return header;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 30 : 0;
}


//section右侧index数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    tableView.sectionIndexColor = WeChatRGB40;
    return self.dataSource2;
}

//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

    }];
    
    return @[editAction];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
