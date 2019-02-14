//
//  WeChatDiscoverListModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatDiscoverListModel.h"

@implementation WeChatDiscoverListModel

+ (NSArray *)localData{
    NSMutableArray *localData = [NSMutableArray array];
    
    NSInteger count = [self photos].count;
    for (int i = 0 ; i < count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        
        NSArray *photo = [self photos][i];
        NSArray *name = [self names][i];
        
        for (int j = 0; j < photo.count; j++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:photo[j] forKey:@"photo"];
            [dic setObject:name[j] forKey:@"name"];
            [arr addObject:dic];
        }
        [item setValue:arr forKey:@"item"];
        [localData addObject:item];
    }
    
    return localData;
}

+ (NSArray *)photos{
    return @[
             @[@"wechat_discover_friendsCircle"],
             @[@"wechat_discover_sweep",
             @"wechat_discover_shake"],
             @[@"wechat_discover_personNear"],
             @[@"wechat_discover_shopping",
             @"wechat_discover_game"]
             ];
}

+ (NSArray *)names{
    return @[
             @[@"朋友圈"],
             @[@"扫一扫",
             @"摇一摇"],
             @[@"附近的人"],
             @[@"购物",
             @"游戏"]
             ];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"item" : [WeChatDiscoverItem class]};
}

@end

@implementation WeChatDiscoverItem

@end
