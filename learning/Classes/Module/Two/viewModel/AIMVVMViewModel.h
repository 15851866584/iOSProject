//
//  AIMVVMViewModel.h
//  learning
//
//  Created by 祥伟 on 2018/12/12.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIMVVMViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
