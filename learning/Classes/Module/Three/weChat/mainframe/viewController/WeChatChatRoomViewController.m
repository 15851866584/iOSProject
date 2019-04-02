//
//  WeChatChatRoomViewController.m
//  learning
//
//  Created by 祥伟 on 2019/3/25.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatChatRoomViewController.h"
#import "WeChatChatRoomModel.h"
#import "AIBaseTableView.h"
#import "WeChatChatTableViewCell.h"
#import "WeChatChatRoomInputView.h"

@interface WeChatChatRoomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AIBaseTableView *tableView;

//图片浏览器
@property (nonatomic, strong)PYPhotoBrowseView *photoBroseView;
@property (nonatomic, strong)WeChatChatRoomInputView *chatInputView;
@end

@implementation WeChatChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.weChatName;
    
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItems.firstObject;
    
    if (_badgeCount) {
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIButton *customBtn = [[UIButton alloc]initWithFrame:CGRectMake(-11, 11, 20, 20)];
        customBtn.backgroundColor = WeChatRGB214;
        customBtn.enabled = NO;
        customBtn.layer.cornerRadius = 10;
        customBtn.layer.masksToBounds = YES;
        customBtn.titleLabel.font = WeChatFont14;
        [customBtn setTitleColor:WeChatRGB20 forState:UIControlStateNormal];
        NSString *beginCount = [NSString stringWithFormat:@"%ld",self.badgeCount];
        [customBtn setTitle:beginCount forState:UIControlStateNormal];
        [customView addSubview:customBtn];
        UIBarButtonItem *countItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
        
        
        self.navigationItem.leftBarButtonItems = @[backItem,countItem];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_badgeCount > _unreadCount) {
                NSString *endCount = [NSString stringWithFormat:@"%ld",self.badgeCount-self.unreadCount];
                [customBtn setTitle:endCount forState:UIControlStateNormal];
            }else{
                self.navigationItem.leftBarButtonItems = @[backItem];
            }
            
        });
    }
    
    
    [self setUpSubViews];
}


- (void)setUpSubViews{
    //数据源
    if (arc4random()%2) {
        [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatChatRoomModel class] json:WeChatChatRoomModel.responseObject]];
    }

    //布局 tableview，底部输入框
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatInputView];
    
    @weakify(self)
    //造数据
    [self.chatInputView setDidSelectFinishBlock:^(NSString * _Nonnull text) {
        @strongify(self);
        if([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
            [self text:@"输入值不能为空格"];
            return ;
        }
        NSDictionary *dic = @{@"photo":@"wechat_me_face.jpg",
                              @"messageType":[NSNumber numberWithInt:CRMessageTypeMine],
                              @"messageText":text
                              };
        [self loadMineData:@[dic]];
    }];
    
    //下拉加载更多
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    //网络请求后
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dataSource.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    });
    
   
}

//加载更多数据
- (void)loadMoreData{
    
    //开始位置
    CGFloat beginPoint = self.tableView.contentSize.height;
    [self.tableView.mj_header endRefreshing];

    //处理数据源
    NSArray *temp = [NSArray arrayWithArray:self.dataSource];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatChatRoomModel class] json:WeChatChatRoomModel.responseObject]];
    [self.dataSource addObjectsFromArray:temp];
    [self.tableView reloadData];
    
    //滚动到加载位置
    [self.tableView beginUpdates];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-beginPoint-60) animated:NO];
    [self.tableView endUpdates];

}

//加载个人消息
- (void)loadMineData:(NSArray *)data{
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[WeChatChatRoomModel class] json:data]];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatChatTableViewCell *cell = [WeChatChatTableViewCell initWithTableView:tableView];
    cell.messageModel = self.dataSource[indexPath.row];
    
    @weakify(self)
    [cell setDidSelectLinkBlock:^(NSString * _Nonnull link, WeChatClickMessageType type) {
        @strongify(self)
        [self.chatInputView hidden];
        
        if (type == WeChatClickMessageTypeURL) {
            NSString *urlString = [NSString stringWithFormat:@"AIWebViewController?url=%@",link];
            OpenURL(urlString);
        }else if (type == WeChatClickMessageTypeEmail){
            [self text:@"这个可能是邮箱"];
        }else if (type == WeChatClickMessageTypePhoneNumber){
            [self text:@"这个可能是电话"];
        }else if (type == WeChatClickMessageTypeImage){
            //处理图片点击方式
            [self dealCurrentIndex:indexPath.row andLink:link];
        }
    }];
    return cell;
}


- (void)dealCurrentIndex:(NSInteger)index andLink:(NSString *)link{
    CGRect rect = CGRectFromString(link);
    self.photoBroseView.frameFormWindow = rect;
    self.photoBroseView.frameToWindow = rect;
    
    NSMutableArray *images = [NSMutableArray array];
    NSInteger currentIndex = 0;
    
    for (WeChatChatRoomModel *model in self.dataSource) {
        if (model.messageImage.length > 0) {
            [images addObject:IMG(model.messageImage)];
        }
    }
    
    for (int i = 0; i < index; i++) {
        WeChatChatRoomModel *model = self.dataSource[i];
        if (model.messageImage.length > 0) {
            currentIndex++;
        }
    }
    
    self.photoBroseView.images = images;
    self.photoBroseView.currentIndex = currentIndex;
    [self.photoBroseView show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [self.tableView cellHeightForIndexPath:indexPath model:self.dataSource[indexPath.row] keyPath:@"messageModel" cellClass:[WeChatChatTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.chatInputView hidden];
}

#pragma mark --setter/getter
- (PYPhotoBrowseView *)photoBroseView{
    if (!_photoBroseView) {
        _photoBroseView = [[PYPhotoBrowseView alloc]init];
        _photoBroseView.hiddenPageControl = YES;
    }
    return _photoBroseView;
}

- (WeChatChatRoomInputView *)chatInputView{
    if (!_chatInputView) {
         _chatInputView = [[WeChatChatRoomInputView alloc]initWithFrame:CGRectMake(0,VB(_tableView), SCREEN_WIDTH, AI_TabbarHeight)];
       
    }
    return _chatInputView;
}

- (AIBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;//滚动键盘消失
    
    }
    return _tableView;
}

@end
