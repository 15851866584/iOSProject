//
//  NSString+Tools.h
//  learning
//
//  Created by 祥伟 on 2018/6/22.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

//md5加密
- (NSString *)md5;

//识别某集合元素 set集合 edg:小数"0123456789."
- (BOOL)isContainSet:(NSString *)set;

//字符串通过某集合元素分割
- (NSArray *)separateBySet:(NSString *)set;

/*
 *  数字格式化 0-9.
 *
 *  @param    numberStyle 样式
 *
 *  eg:1194862.57
 *  NSNumberFormatterNoStyle         : 1194863        四舍五入
 *  NSNumberFormatterDecimalStyle    : 1,194,862.57   千位一隔开
 *  NSNumberFormatterCurrencyStyle   : $1,194,862.57  货币单位
 *  NSNumberFormatterPercentStyle    : 119,486,257%   百分比
 *  NSNumberFormatterScientificStyle : 1.19486257E6   科学计数
 *  NSNumberFormatterSpellOutStyle   :
 *
 */
- (NSString *)stringByNumberStyle:(NSNumberFormatterStyle)numberStyle;


//通过图片Data数据第一个字节 来获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data;

//简单判断本地gif
- (BOOL)isGif;


//----------------------------------------------
/** 正则表达式 */
- (BOOL)isValidateByRegex:(NSString *)regex;

/** 判断是否为纯数字 */
- (BOOL)isPureDigital;

/** 判断是否为纯字母 */
- (BOOL)isPureLetters;

/** 判断是否有效url */
- (BOOL)isValidUrl;

/** 验证邮箱 */
- (BOOL)isValidateEmail;

/** 验证手机号 非严谨:1开头11位纯数字 */
- (BOOL)isMobileNumber;

/** 验证手机号 严谨:运营商号段，正则号段可能有不全，自己可以添加 */
- (BOOL)isPhoneNumber;

/** 验证运营商:移动 */
- (BOOL)isMobileOperators;

/** 验证运营商:联通 */
- (BOOL)isUnicomOperators;

/** 验证运营商:电信 */
- (BOOL)isTelecomOperators;

// 获取手机号运营商
- (NSString *)mobilePhoneOperators;

/** 简单验证身份证:15或18位 */
- (BOOL)isSimpleVerifyIdentityCard;


@end
