//
//  AIMVVMViewModel.m
//  learning
//
//  Created by 祥伟 on 2018/12/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIMVVMViewModel.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"

@interface AIMVVMViewModel ()
@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AIMVVMViewModel


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEOETableViewCell *cell = [AIEOETableViewCell initWithTableView:tableView];
    cell.title = self.dataSource[indexPath.row];
    
    return cell;
}

- (instancetype)initWithViewController:(UIViewController *)vc{
    if (self = [super init]) {
        
        _view = [vc valueForKey:@"view"];
        NSDictionary *deviceInfo = [vc valueForKey:@"deviceInfo"];
        [self.dataSource removeAllObjects];
        [[deviceInfo allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *item = [NSString stringWithFormat:@"%@：%@",obj,[deviceInfo valueForKey:obj]];
            [self.dataSource addObject:item];
        }];
        
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-AI_TabbarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.tableView];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
