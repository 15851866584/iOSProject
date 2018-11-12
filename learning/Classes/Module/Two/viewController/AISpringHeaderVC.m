//
//  AISpringHeaderVC.m
//  learning
//
//  Created by 祥伟 on 2018/8/24.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AISpringHeaderVC.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"
#import "AISpringView.h"

@interface AISpringHeaderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AIBaseTableView *tableView;
@end

@implementation AISpringHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarControl = NavigationBarHideShow;
    
    
    self.tableView = [[AIBaseTableView alloc]initWithFrame:CGRectMake(0, 0, VW(self.view), ViewH) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    [self.view addSubview:self.tableView];
    
    AISpringView *spring = [[AISpringView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    spring.bodyScrollView = self.tableView;
    spring.image = IMG(@"saber.jpeg");
    spring.title = @"我是标题";
    [self.view addSubview:spring];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEOETableViewCell *cell = [AIEOETableViewCell initWithTableView:tableView];
    
    cell.title = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
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
