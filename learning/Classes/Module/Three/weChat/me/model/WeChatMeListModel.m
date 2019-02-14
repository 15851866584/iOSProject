//
//  WeChatMeListModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMeListModel.h"

@implementation WeChatMeListModel

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
             @[@"wechat_me_pay"],
             @[@"wechat_me_collection",
               @"wechat_me_photoAlbum",
               @"wechat_me_package",
               @"wechat_me_expression"],
             @[@"wechat_me_configuration"]
             ];
}

+ (NSArray *)names{
    return @[
             @[@"支付"],
             @[@"收藏",
               @"相册",
               @"卡包",
               @"表情"],
             @[@"设置"]
             ];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"item" : [WeChatMeItem class]};
}

@end

@implementation WeChatMeItem

@end
