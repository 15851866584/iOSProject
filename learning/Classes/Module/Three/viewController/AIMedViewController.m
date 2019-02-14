//
//  AIMedViewController.m
//  learning
//
//  Created by 祥伟 on 2018/6/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIMedViewController.h"
#import "AIMedCollectionViewCell.h"
#import "IconModel.h"

//#import "WeChatTabBarController.h"

static NSString *identifier = @"AIMedCollectionViewCell";

@interface AIMedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@end


@implementation AIMedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    
    [self.dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[IconModel class] json:IconModel.responseObject]];
    
    self.view.backgroundColor = AIRGB(235, 204, 185);
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AIMedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.iconModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    OpenURL(@"WeChatTabBarController");
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //最小行间距
        //layout.minimumLineSpacing = 10;
        //最小列间距
        //layout.minimumInteritemSpacing = 10;
        //item大小
        CGFloat width = (SCREEN_WIDTH-75)/4;
        layout.itemSize = CGSizeMake(width, width);
        //内边距
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AI_NavAndStatusHeight, SCREEN_WIDTH, ViewHNT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:NSClassFromString(identifier) forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

@end
