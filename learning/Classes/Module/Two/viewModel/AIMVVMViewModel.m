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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path = [NSString stringWithFormat:@"AIKnowledgeViewController?navTitle=%@",self.dataSource[indexPath.row]];
    OpenURL(path);
}

- (instancetype)initWithViewController:(UIViewController *)vc{
    if (self = [super init]) {
        _vcView = vc.view;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.vcView addSubview:self.tableView];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[
                                                       @"runtime",
                                                       @"KVC",
                                                       @"KVO",
                                                       @"Block",
                                                       @"进程与线程",
                                                       @"多线程",
                                                       @"GCD",
                                                       @"NSOperation",
                                                       @"SEl和IMP",
                                                       @"运行时机制",
                                                       @"消息转发机制原理",
                                                       @"assign和weak的区别",
                                                       @"delegate跟block的区别",
                                                       @"几种传值方式",
                                                       @"OC反射机制",
                                                       @"类方法和实例方法的区别",
                                                       @"objc向nil对象发送消息",
                                                       @"类别能不能添加属性",
                                                       @"NSTimer",
                                                       @"加密",
                                                       @"内存分配",
                                                       @"transform",
                                                       @"CAAnimation",
                                                       @"BezierPath",
                                                       @"锁",
                                                       @"网络七层协议",
                                                       @"HTTP",
                                                       @"TCP和UDP",
                                                       @"字典实现原理",
                                                       @"数据持久化",
                                                       @"NSUserDefault和encode",
                                                       @"CoreData",
                                                       @"FMDB",
                                                       @"App性能监控",
                                                       @"MVC和MVVM",
                                                       @"autoreleasepool",
                                                       @"AFNetworking",
                                                       @"排序",
                                                       @"关键字property等",
                                                       @"app的生命周期",
                                                       @"MLeaksFinder",
                                                       @"字段符号的含义",
                                                       @"预编译指令",
                                                       @"lldb（gdb）常用的调试命令",
                                                       ]];
    }
    return _dataSource;
}

@end
