//
//  AICycleScrollViewController.m
//  learning
//
//  Created by 祥伟 on 2018/8/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AICycleScrollViewController.h"
#import "AIBaseTableView.h"
#import "AIEOETableViewCell.h"
#import "AICycleScrollView.h"
#import "ZJPageControl.h"
@interface AICycleScrollViewController ()<UITableViewDelegate,UITableViewDataSource,AICycleScrollViewDelegate>

@property (nonatomic, strong) AIBaseTableView *tableView;
@property (nonatomic, strong) AICycleScrollView *cycleView;
@property (nonatomic, strong) ZJPageControl *control;
@end

@implementation AICycleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataSource addObjectsFromArray:@[
                                           @"默认(holder页、分页控件、支持本地和网络图片、自动滚动、无限循环、自定义页面)",
                                           @"滚到指定页面(带有滚动动画)",
                                           @"滚动方向(垂直)",
                                           @"滚动方向(逆时针)",
                                           @"禁止自动滚动",
                                           @"禁止无限循环",
                                           @"自动滚动间隔设置5",
                                           @"分页控件位置居左(居左、居中、居右)",
                                           @"隐藏分页控件",
                                           @"分页控件(当前红色,其他灰色)",
                                           @"分页控件(x、y调整)",
                                           ]];
    [self setUpSubViews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleView.imageStringsGroup = @[ @"imageBanner1",
                                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                              @"https://goss.veer.com/creative/vcg/veer/800water/veer-163531717.jpg",
                                              @"https://goss.veer.com/creative/vcg/veer/800water/veer-302375734.jpg"
                                             ];
        
    });
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)setUpSubViews{
    self.tableView = [[AIBaseTableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    [self.view addSubview:self.tableView];
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
    switch (indexPath.row) {
        case 0:
            
            self.cycleView.dragDirection = AICycleScrollViewDragHorizontal;
            self.cycleView.clockwise = YES;
            self.cycleView.autoScroll = YES;
            self.cycleView.infiniteLoop = YES;
            self.cycleView.autoScrollTimeInterval = 2;
            self.cycleView.pageControlAlignment = AICyclePageControlAlignmentCenter;
            self.cycleView.hidesForPageControl = NO;
            self.cycleView.currentPageIndicatorColor = [UIColor whiteColor];
            self.cycleView.pageIndicatorColor = [UIColor colorWithWhite:0.5 alpha:0.5];
            self.cycleView.pageControlVerticalOffset = 10;
            self.cycleView.pageControlHorizontalOffset = -10;
        case 1:
            [self.cycleView scrollToItemAtIndex:0 animated:NO];
            break;
        case 2:
            self.cycleView.dragDirection = AICycleScrollViewDragVertical;
            break;
        case 3:
            self.cycleView.clockwise = NO;
            break;
        case 4:
            self.cycleView.autoScroll = NO;
            break;
        case 5:
            self.cycleView.infiniteLoop = NO;
            break;
        case 6:
            self.cycleView.autoScrollTimeInterval = 5;
            break;
        case 7:
            self.cycleView.pageControlAlignment = AICyclePageControlAlignmentRight;
            break;
        case 8:
            self.cycleView.hidesForPageControl = YES;
            break;
        case 9:
            self.cycleView.currentPageIndicatorColor = [UIColor redColor];
            self.cycleView.pageIndicatorColor = [UIColor grayColor];
            break;
        case 10:
            self.cycleView.pageControlVerticalOffset = -10;
            self.cycleView.pageControlHorizontalOffset = 10;
            break;

        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.cycleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.cycleView.height;
}

//- (UIView *)cycleScrollViewCustomPageControl:(AICycleScrollView *)cycleScrollView{
//    ZJPageControl *control = [[ZJPageControl alloc]initWithFrame:CGRectMake(0, VH(cycleScrollView)-40, VW(cycleScrollView), 30)];
//    control.backgroundColor = [UIColor clearColor];
//    control.pageIndicatorTintColor = [UIColor blueColor];
//    control.currentPageIndicatorTintColor = [UIColor greenColor];
//    control.numberOfPages = 4;
//    control.currentPage = 0;
//    control.userInteractionEnabled = NO;
//    self.control = control;
//    return control;
//}

- (void)cycleScrollView:(AICycleScrollView *)cycleScrollView didChangeToIndex:(NSInteger)index{

    [self.control setCurrentPage:index animated:YES];
}

//- (NSArray *)cycleScrollView:(AICycleScrollView *)cycleScrollView addSubviewsAtIndex:(NSInteger)index{
//    NSString *text = [NSString stringWithFormat:@"   我是第%zd页",index];
//    UILabel *lab = [UILabel labelWithFrame:CGRectMake(0, VH(cycleScrollView)-30, VW(cycleScrollView), 30) textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14] text:text];
//    lab.backgroundColor = [UIColor yellowColor];
//    return @[lab];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AICycleScrollView *)cycleView{
    if (!_cycleView) {
        _cycleView = [AICycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self imageStringsGroup:@[@""] placeholderImage:IMG(@"placeholderImage")];
//        _cycleView.pageIndicatorImage = [UIImage createImageWithColor:[UIColor redColor] size:CGSizeMake(20, 10)];
//        _cycleView.currentPageIndicatorImage = [UIImage createImageWithColor:[UIColor blueColor] size:CGSizeMake(20, 10)];
        
    }
    return _cycleView;
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
