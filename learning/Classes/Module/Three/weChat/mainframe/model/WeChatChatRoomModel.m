//
//  WeChatChatRoomModel.m
//  learning
//
//  Created by 祥伟 on 2019/3/27.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatChatRoomModel.h"

@implementation WeChatChatRoomModel

+ (NSArray *)responseObject{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        int random = arc4random()%8;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        if (random) {
            NSString *photo = [NSString stringWithFormat:@"%d.jpg",random];
            [dic setValue:photo forKey:@"photo"];
            [dic setValue:[NSNumber numberWithInt:CRMessageTypeOthers] forKey:@"messageType"];
        }else{
            [dic setValue:@"wechat_me_face.jpg" forKey:@"photo"];
            [dic setValue:[NSNumber numberWithInt:CRMessageTypeMine] forKey:@"messageType"];
        }
        
        
        int random2 = arc4random()%([self messageText].count);
        if (random2%6 == 0) {
            NSString *image = [NSString stringWithFormat:@"image%d.png",random2/6];
            [dic setValue:image forKey:@"messageImage"];
        }else{
            
            [dic setValue:[self messageText][random2] forKey:@"messageText"];
        }

        [array addObject:dic];
    }
    return array;
    
}

+ (NSArray *)messageText{
    return @[@"下载地址http://www.cocoachina.com/ios/20151223/14778.html",
             @"呵呵",
             @"今天是3月28日星期四，苹果iOS12.3第一个开发者测试版更新了Apple TV。苹果在为所有用户发布iOS12.2正式版两天后，今天苹果推送了iOS12.3第一个开发者测试版。iOS 12.3的第一个版本是16F5117h，对于参与苹果开发者计划的开发人员，该更新应该在最新时刻开始提供安装了beta配置文件。与iOS测试周期一样，苹果会在为开发人员发布第一个测试版之后，将会很快推送iOS12.3的公开测试版",
             @"脱掉，脱掉，统统脱掉,有木有人儿？😎",
             @"😤😤😤😤😤",
             @"什么事？",
             @"您好",
             @"电话：15851888888",
             @"LG折叠屏手机渲染图曝光：外翻折设计可玩性更高",
             @"苹果发布会：尬聊2小时，蒸发100亿",
             @"哈哈",
             @"😺",
             @"苹果推出新闻服务Apple News+，支持杂志的订阅，服务费用为9.99美元/月。",
             @"苹果推出信用卡服务Apple Card，支持每日提现，今年夏天美国上线",
             @"苹果推出游戏订阅服务Apple Arcade，支持超过100款独占游戏，国区上线有望",
             @"苹果更新Apple TV应用服务，推出Apple TV+视频流媒体，今年秋天上线。",
             @"一段炫酷开场动画视频之后，库克登场",
             @"好的",
             @"是的",
             @"邮箱648099999@qq.com",
             @"事实上，此前一天市场便传出了国泰航空已同意收购香港快运的消息，公司当日股价上涨2.7%。但27日正式消息公布后，国泰航空股价下跌2.49%，报收于13.34港元/股",
             @"民航专家林智杰向《每日经济新闻》记者分析称：“这次收购如果完成，对国泰航空业绩有一定帮助。如仅考虑香港本土航司，国泰航空已经收购港龙航空，若此次成功收购香港快运，国泰系将控制香港市场大部分份额……同时，香港快运是低成本航司，将与高大上的国泰和服务不错的港龙形成差异化的互补定位，进一步提升整个国泰系对不同客群的市场覆盖",
             @"个人简书地址：https://www.jianshu.com/u/1ce8edc3912f,总结一些知识点",
             ];
}



@end
