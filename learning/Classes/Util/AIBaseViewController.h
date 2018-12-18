//
//  AIBaseViewController.h
//  learning
//
//  Created by 祥伟 on 2018/6/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIBaseViewController : UIViewController

/*
 *  数据源 
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataSource2;
@property (nonatomic, strong) NSMutableArray *dataSource3;

/*
 *   HUD
 *   实现图文共存
 */
- (void)text:(NSString *)text;
- (void)icon:(NSString *)icon;
- (void)HUD:(NSString *)text icon:(NSString *)icon;
- (void)HUD:(NSString *)text images:(NSArray *)images;
- (void)HUD:(NSString *)text type:(HUDLoadingType)type;

- (void)hideHUDs;

//返回事件
- (void)backUpViewController;
//privite 这里可以根据具体情况去实现私有api
//- (void)showSuccess;
//- (void)showError;
//- (void)showLoading;



@end
