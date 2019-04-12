//
//  AIColorConfig.h
//  learning
//
//  Created by 祥伟 on 2018/6/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#ifndef AIColorConfig_h
#define AIColorConfig_h

#define AIRGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define AIRGB(R, G, B) AIRGBA(R, G, B, 1.0)
#define AIRandom_color AIRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define AIHEXRGBA(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
#define AIHEXRGB(rgbValue) AIHEXRGBA(rgbValue,1.0)


#define AI_RGBZero AIRGB(0, 0, 0)
#define AI_RGB51 AIRGB(51, 51, 51)
#define AI_RGB125 AIRGB(125, 125, 125)
#define AI_RGB255 AIRGB(255, 255, 255)

//weChat颜色值
#define WeChatRGB0 AIRGB(0, 0, 0)
#define WeChatRGB20 AIRGB(20, 20, 20)
#define WeChatRGB40 AIRGB(40, 40, 40)
#define WeChatRGB110 AIRGB(110, 110, 110)
#define WeChatRGB160 AIRGB(160, 160, 160)
#define WeChatRGB200 AIRGB(200, 200, 200)
#define WeChatRGB214 AIRGB(214, 214, 214)
#define WeChatRGB234 AIRGB(234, 234, 234)
#define WeChatRGB241 AIRGB(241, 241, 241)
#define WeChatRGB246 AIRGB(246, 246, 246)
#define WeChatRGB254 AIRGB(254, 254, 254)
#define WeChatRGB256 AIRGB(256, 256, 256)


#define WeChatBlue AIRGB(30, 182, 95)
#define WeChatGreen AIRGB(69, 138, 213)
#define WeChatPurple AIRGB(120, 138, 169)
#define WeChatLightGreen AIRGB(162, 229, 99)
#endif /* AIColorConfig_h */
