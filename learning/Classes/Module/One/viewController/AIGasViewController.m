//
//  AIGasViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIGasViewController.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"
#import "AISecondTabBarController.h"
#import "Knowledge.h"
#import "NSObject+Tools.h"
#import <objc/message.h>
@interface AIGasViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) NSString *string;
@end

@implementation AIGasViewController
{
    NSString *_string;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UILabel *lab = [UILabel labelWithFrame:CGRectMake(0, 0, 100, 30) textColor:[UIColor blackColor] font:AI_SYSTEM_Size(20) text:@"加载中..." textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = lab;
    [lab startActivityIndicatorColor:[UIColor redColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lab stopActivityIndicator];
        lab.text = @"总结";
    });
   
    [self.dataSource addObjectsFromArray:@[
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
                     @"assign和weak的区别",
                     @"delegate跟block的区别",
                     @"消息转发机制原理",
                     @"几种传值方式",
                     @"OC反射机制",
                     @"类方法和实例方法的区别",
                     @"排序",
                     @"objc向nil对象发送消息",
                     @"类别能不能添加属性",
                     @"lldb（gdb）常用的调试命令",
                     @"NSTimer",
                     @"网络七层协议",
                     @"HTTP",
                     @"TCP和UDP",
                     @"字典实现原理",
                     @"预编译指令",
                     @"数据持久化",
                     @"NSUserDefault",
                     @"CoreData",
                     @"FMDB",
                     @"App性能监控",
                     @"MLeaksFinder",
                     @"MVC和MVVM",
                     @"autoreleasepool",
                     @"字段符号的含义",
                     @"app的生命周期",
                     @"AFNetworking",
                     @"加密",
                     @"内存分配",
                     @"transform",
                     @"CAAnimation",
                     @"BezierPath",
                     @"锁",
                     @"关键字property等"
                                           ]];
    [self setUpSubViews];
    [NSObject printIvarsList:[self class]];
}

- (void)click:(UIButton *)btn{
    [btn.titleLabel startActivityIndicator];
    
}

- (void)setUpSubViews{

    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHNT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMG(@"small_normal_sel") style:(UIBarButtonItemStylePlain) target:self action:@selector(newTab)];
}

- (void)newTab{
    OpenURL(@"AISecondTabBarController?navigationBarControl=4");
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
