//
//  AIFontConfig.h
//  learning
//
//  Created by 祥伟 on 2018/6/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#ifndef AIFontConfig_h
#define AIFontConfig_h

// S -> size
#define AI_SYSTEM_Size(S)      [UIFont systemFontOfSize:S]
#define AI_BOLD_SYSTEM_Size(S) [UIFont boldSystemFontOfSize:S]


#define UNSize20 [UIFont fontWithName:@"UniversLTStd-UltraCn" size:20]

//weChat字体大小
#define WeChatFont10 AI_SYSTEM_Size(10)
#define WeChatFont12 AI_SYSTEM_Size(12)
#define WeChatFont14 AI_SYSTEM_Size(14)
#define WeChatFont16 AI_SYSTEM_Size(16)
#define WeChatFont18 AI_SYSTEM_Size(18)
#define WeChatFont20 AI_SYSTEM_Size(20)
#define WeChatFont28 AI_SYSTEM_Size(28)

#define WeChatFontBold24 AI_BOLD_SYSTEM_Size(24)

#endif /* AIFontConfig_h */
