//
//  WeChatMessageListModel.m
//  learning
//
//  Created by 祥伟 on 2019/1/25.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatMessageListModel.h"

@implementation WeChatMessageListModel

+ (NSArray *)responseObject{
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *photo = [NSString stringWithFormat:@"%d.jpg",i];
        [dic setValue:photo forKey:@"photo"];
        
        [dic setValue:[self names][i] forKey:@"name"];
        
        [dic setValue:[self messages][i] forKey:@"message"];
        
        [dic setValue:[self silents][i] forKey:@"silent"];
        
        [array addObject:dic];
        
        int random = arc4random()%(i+1);
        
        [array exchangeObjectAtIndex:0 withObjectAtIndex:random];
    }

    NSMutableArray *object = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
        [dic setValue:[self times][idx] forKey:@"time"];
        
        if (idx < 5) {
            int random = arc4random()%5+1;
            [dic setValue:[NSNumber numberWithInt:random] forKey:@"unreadCount"];
        }else{
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"unreadCount"];
        }
        
        [object addObject:dic];
    }];
    
    return object;
}

+ (NSArray *)names{

    return @[@"二龙湖浩哥",
             @"微风",
             @"夜在哭泣🍃",
             @"GSD_iOS",
             @"hello world",
             @"大脸猫😎",
             @"你似不似傻",
             @"天天向上",
             @"不爱掏粪男孩",
             @"🌺最爱欧巴🌺",
             @"大长腿思密达",
             @"别给我晒脸",
             @"可爱男孩",
             @"筷子姐妹",
             @"法海你不懂爱",
             @"长城长✌️",
             @"老北京麻辣烫",
             @"我不搞笑😤",
             @"原来我不帅",
             @"亲亲我的宝贝",
             @"请叫我吴彦祖",
             @"帅锅莱昂纳多",
             @"星星之火",
             @"雅蠛蝶~雅蠛蝶"
             ];
}

+ (NSArray *)messages{

    return @[@"二龙湖浩哥：什么事？",
             @"麻蛋！！！",
             @"夜在哭泣：好好地，🐂别瞎胡闹",
             @"GSD_iOS：SDAutoLayout  下载地址http://www.cocoachina.com/ios/20151223/14778.html",
             @"我不懂",
             @"这。。。。。。酸爽~ http://www.cocoachina.com/ios/20151223/14778.html",
             @"你似不似傻：呵呵",
             @"天天向上：辛苦了！",
             @"新年快乐！猴年大吉！摸摸哒 http://www.cocoachina.com/ios/20151223/14778.html",
             @"[呲牙][呲牙][呲牙]",
             @"大长腿思密达：[图片]",
             @"坑死我了。。。。。",
             @"：你谁？？？",
             @"筷子姐妹：和尚。。尼姑。。",
             @"法海你不懂爱：春晚太难看啦，妈蛋的",
             @"好好好~~~",
             @"老北京麻辣烫：约起 http://www.cocoachina.com/ios/20151223/14778.html",
             @"我不搞笑😤：寒假过得真快",
             @"原来我不帅：有木有人儿？",
             @"你说啥呢",
             @"好搞笑🐎，下次还来",
             @"帅锅莱昂纳多：我不理解 http://www.cocoachina.com/ios/20151223/14778.html",
             @"脱掉，脱掉，统统脱掉",
             @"雅蠛蝶~雅蠛蝶：好脏，好污，好喜欢"
             ];
}

+ (NSArray *)times{
    return @[
             @"上午10:21",
             @"上午10:18",
             @"上午9:08",
             @"上午9:07",
             @"上午9:06",
             @"上午9:05",
             @"上午9:01",
             @"2019/1/10",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天",
             @"昨天"
             ];
}

+ (NSArray *)silents{
    return @[
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             ];
}

+ (NSArray *)read{
    return @[
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             @"true",
             @"flase",
             ];
}

@end
