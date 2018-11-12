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

#endif /* AIColorConfig_h */
