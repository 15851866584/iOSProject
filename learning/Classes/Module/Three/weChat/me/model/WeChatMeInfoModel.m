//
//  WeChatMeInfoModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/31.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMeInfoModel.h"

@implementation WeChatMeInfoModel

+ (NSDictionary *)responseObject{
    return @{
             @"photo":@"wechat_me_face.jpg",
             @"name":@"土豆赶着鸡",
             @"code":@"微信号：xw010109"
             };
}

@end
