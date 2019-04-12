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
             @"联讯证券：市场持续上涨后，估值修复较为充分，有所调整等待基本面的进一步确认属于情理之中。北上资金也在择机换仓，减仓消费，加仓银行、保险等。通胀平稳上行，建议关注生猪和上游资源品板块。\n中原证券：A股市场处于年报一季报集中发布的时期，上市公司业绩的变化情况可能对于投资者的认知同样可能产生较大的影响。沪指自2440点开启超跌反弹以来，短期涨幅较大，市场已基本反应了可以预期的诸多利好因素。未来股指若要继续向上拓展更大的上涨空间，依然需要政策面以及资金面超预期的政策扶持和推动。建议投资者后市可继续关注累计涨幅较小，估值相对较为合理的绩优蓝筹股的中线机会。\n国盛证券：基本面既不会断崖式下行，也不会出现V形拐点，更类似L形底部。但从策略角度看，短期反而不用太较真。一方面，近期的高频数据，无论消费端或大宗商品价格仍在反映需求回暖，证伪也至少要到4月数据出来时。另一方面，当前市场情绪仍高，熊市思维已经被扭转，因此即使复苏是短期的，市场完全有可能过度反应，因此积极参与博弈",
             @"😤😤😤😤😤",
             @"什么事？",
             @"您好",
             @"电话：15851888888",
             @"LG折叠屏手机渲染图曝光：外翻折设计可玩性更高",
             @"苹果发布会：尬聊2小时，蒸发100亿",
             @"经查，视觉中国网站(域名为vcg.com)在其发布的多张图片中刊发敏感有害信息标注，引起网上大量转发，破坏网络生态，造成恶劣影响。上述行为违反了《网络安全法》《互联网信息服务管理办法》有关规定。根据《互联网信息内容管理行政执法程序规定》，我办依法约谈该网站负责人，责令视觉中国网站立即停止传输相关信息，采取措施消除恶劣影响，并保存相关记录。要求其切实履行网站主体责任，从严处理相关责任人，全面清查历史存量信息，同时要求该网站加强内容审核管理和编辑人员教育培训，杜绝类似问题再次发生。",
             @"App Store是成就苹果崛起的重要因素，iOS的封闭机制导致它成为用户下载安装应用的唯一常规入口。不过，苹果这项曾经让自己和开发者共同受益的机制，开始越来越受到质疑。",
             @"苹果推出新闻服务Apple News+，支持杂志的订阅，服务费用为9.99美元/月。",
             @"苹果推出信用卡服务Apple Card，支持每日提现，今年夏天美国上线",
             @"苹果推出游戏订阅服务Apple Arcade，支持超过100款独占游戏，国区上线有望",
             @"苹果更新Apple TV应用服务，推出Apple TV+视频流媒体，今年秋天上线。",
             @"一段炫酷开场动画视频之后，库克登场",
             @"东吴证券：在当前的市场环境下，板块仍有结构性机会。其一是同时具备宏观逻辑和产业逻辑的科技股，其二是具备高风险偏好属性的军工，其三就传统行业而言，右侧关注猪养殖、左侧关注早周期性行业，如汽车等。除此之外，科创板推出的背景下，券商股也直接受益",
             @"山西证券：在3200-3300点之间的震荡投资者不必过于担忧，市场强势的特征已经在这一阶段的行情中体现出来。短期行业配置只需抓住两条主线：一是大金融板块，尤其是银行板块带动大盘再次上攻的机会；二是估值低位、业绩改善的消费类白马以及地产龙头、机械等部分大盘蓝筹。在年报披露密集期内，放弃对热点概念以及事件驱动型股票的炒作",
             @"邮箱648099999@qq.com",
             @"事实上，此前一天市场便传出了国泰航空已同意收购香港快运的消息，公司当日股价上涨2.7%。但27日正式消息公布后，国泰航空股价下跌2.49%，报收于13.34港元/股",
             @"民航专家林智杰向《每日经济新闻》记者分析称：“这次收购如果完成，对国泰航空业绩有一定帮助。如仅考虑香港本土航司，国泰航空已经收购港龙航空，若此次成功收购香港快运，国泰系将控制香港市场大部分份额……同时，香港快运是低成本航司，将与高大上的国泰和服务不错的港龙形成差异化的互补定位，进一步提升整个国泰系对不同客群的市场覆盖",
             @"个人简书地址：https://www.jianshu.com/u/1ce8edc3912f,总结一些知识点",
             ];
}



@end
