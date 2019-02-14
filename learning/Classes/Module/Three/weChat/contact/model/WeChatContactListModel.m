//
//  WeChatContactListModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/28.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatContactListModel.h"




@implementation WeChatContactListModel

+ (NSArray *)responseObject{
    //借用首页的数据
    Class cls = NSClassFromString(@"WeChatMessageListModel");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSArray *dataSource = [cls performSelector:NSSelectorFromString(@"responseObject")];
#pragma clang diagnostic pop
    
    
    return dataSource;
}

+ (NSArray *)localData{
    return @[@{@"contact":@[
                       @{@"photo":@"wechat_contact_newfriend",
                         @"name":@"新的朋友"},
                       @{@"photo":@"wechat_contact_groupfriend",
                         @"name":@"群聊"},
                       @{@"photo":@"wechat_contact_tag",
                         @"name":@"标签"},
                       @{@"photo":@"wechat_contact_public",
                         @"name":@"公众号"}
                       ],
               @"letter":@""}];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"contact" : [WeChatContactMessage class]};
}
@end

@implementation WeChatContactMessage

@end
