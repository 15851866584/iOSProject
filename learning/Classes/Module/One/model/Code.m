//
//  Code.m
//  learning
//
//  Created by 祥伟 on 2018/11/13.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "Code.h"

@implementation Code

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count ; i++) {
        Ivar ivar = ivars[i];
        
        const char * name = ivar_getName(ivar);
        NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        NSString *value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count;
        
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count ; i++) {
            Ivar ivar = ivars[i];
            
            const char * name = ivar_getName(ivar);
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            NSString *value = [aDecoder valueForKey:key];
            
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    
    return self;
    
}



@end
