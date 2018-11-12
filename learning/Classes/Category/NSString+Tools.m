//
//  NSString+Tools.m
//  learning
//
//  Created by 祥伟 on 2018/6/22.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "NSString+Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@implementation NSString (Tools)

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result);

    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)isContainSet:(NSString *)set{
    if (!set) return NO;
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:set] invertedSet];
    NSString *filter = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filter];
}

- (NSArray *)separateBySet:(NSString *)set{
    NSMutableArray *result = [NSMutableArray array];
    //记录下标
    int flag = 0;
    
    for (int i = 1 ; i < self.length ; i++) {
        
        NSString *first = [self substringWithRange:NSMakeRange(i-1, 1)];
        NSString *last  = [self substringWithRange:NSMakeRange(i, 1)];
        
        if ([first isContainSet:set] != [last isContainSet:set]) {
            [result addObject:[self substringWithRange:NSMakeRange(flag, i-flag)]];
            flag = i;
        }
    }
    [result addObject:[self substringWithRange:NSMakeRange(flag, self.length-flag)]];
    return result;
}


//----------------------------------------------
- (NSString *)stringByNumberStyle:(NSNumberFormatterStyle)numberStyle{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = numberStyle;
    return [formatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
}

//----------------------------------------------
- (NSString *)contentTypeForImageData:(NSData *)data{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

- (BOOL)isGif{
    if ([[self pathExtension] isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

//----------------------------------------------
- (BOOL)isValidateByRegex:(NSString *)regex{
    if (regex.length <= 0) return NO;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isPureDigital{
    return [self isValidateByRegex:@"[0-9]*"];
}

- (BOOL)isPureLetters{
    return [self isValidateByRegex:@"[a-zA-Z]*"];
}

- (BOOL)isValidUrl{
    return [self isValidateByRegex:@"[a-zA-z]+://[^\\s]*"];
}

- (BOOL)isValidateEmail{
    return [self isValidateByRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL)isMobileNumber{
    if (self.length != 11 || ![self hasPrefix:@"1"]) {
        return NO;
    }
    if (![self isPureDigital]) {
        return NO;
    }
    return YES;
}

- (BOOL)isPhoneNumber{

    /**
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    
    /**
     * 手机号段正则表达式
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    
    return [self isValidateByRegex:MOBILE];
}

- (BOOL)isMobileOperators{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    
    return [self isValidateByRegex:CM_NUM];
}

- (BOOL)isUnicomOperators{
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    
    return [self isValidateByRegex:CU_NUM];
}

- (BOOL)isTelecomOperators{
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    return [self isValidateByRegex:CT_NUM];
}

- (NSString *)mobilePhoneOperators{
    return [self isMobileOperators]?@"中国移动":([self isUnicomOperators]?@"中国联通":([self isTelecomOperators]?@"中国电信":@"未知"));
}

- (BOOL)isSimpleVerifyIdentityCard{
    return [self isValidateByRegex:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

@end
