//
//  NSObject+Tools.m
//  learning
//
//  Created by 祥伟 on 2018/8/17.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "NSObject+Tools.h"
#import <objc/runtime.h>

@implementation NSObject (Tools)

- (void)changeValueForProperty:(NSDictionary *)property{

    [property enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyPath = [key componentsSeparatedByString:@"."].lastObject;
        
        if ([self matchClassObj:obj keyPath:keyPath]){
            [self setValue:obj forKeyPath:key];
        }
    }];
}

- (BOOL)matchClassObj:(id)obj keyPath:(NSString *)keyPath{
    NSDictionary *property = [self propertyGenericClass];
    Class cla = [[property objectForKey:keyPath] class];
    if ([obj isKindOfClass:cla]) {
        return YES;
    }
    return NO;
}

- (NSDictionary *)genericClass{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self propertyGenericClass]];
    if ([self respondsToSelector:@selector(customPropertyGenericClass)]) {
        NSDictionary *custom = [self customPropertyGenericClass];
        if (custom) [dic addEntriesFromDictionary:[self customPropertyGenericClass]];
    }
    return dic;
}

- (NSDictionary *)propertyGenericClass{
    return @{
             
             @"font" : [UIFont class],
             @"text" : [NSString class],
             @"image" : [UIImage class],
             @"textColor" : [UIColor class],
             @"backgroundColor" : [UIColor class]
             };
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)printPropertysList:(Class)cla{
    if (!class_isMetaClass(object_getClass(cla))) return;
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(cla, &propertyCount);
    if (!properties) return;
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        DLog(@"%@:%@",attribute,name);
    }
    
    free(properties);
}

+ (void)printIvarsList:(Class)cla{
    if (!class_isMetaClass(object_getClass(cla))) return;
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(cla, &count);
    if (!ivars) return;
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        DLog(@"%@:%@",type,name);
    }
    
    free(ivars);
}

+ (void)printAllIvarsList:(Class)cla{
    while (class_isMetaClass(object_getClass(cla))) {
        [self printIvarsList:cla];
        cla = [cla superclass];
    }
}

//----------------------------------------------

- (void)performMethod:(NSString *)method{
    if (!method) return;
    
    SEL sel = NSSelectorFromString(method);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL) = (void *)imp;
        func(self, sel);
    }
}


- (void)performMethod:(NSString *)method withObject:(id)object{
    if (!method) return;
    
    SEL sel = NSSelectorFromString(method);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, sel, object);
    }
}

- (void)performMethod:(NSString *)method withObject:(id)object1 withObject:(id)object2{
    if (!method) return;
    
    SEL sel = NSSelectorFromString(method);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, id, id) = (void *)imp;
        func(self, sel, object1, object2);
    }
}

- (void)performMethod:(NSString *)method withBool:(BOOL)object{
    if (!method) return;
    
    SEL sel = NSSelectorFromString(method);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, BOOL) = (void *)imp;
        func(self, sel, object);
    }
}

- (void)performMethod:(NSString *)method withObject:(id)object1 withBool:(BOOL)object2{
    if (!method) return;
    
    SEL sel = NSSelectorFromString(method);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, id, BOOL) = (void *)imp;
        func(self, sel, object1, object2);
    }
}
//----------------------------------------------


+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector{
    swizzleClassMethod(self.class, originSelector, swizzleSelector);
}

- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector{
    swizzleInstanceMethod(self.class, originSelector, swizzleSelector);
}

static void swizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector){
    if (!class_isMetaClass(object_getClass(cls))) {
        return;
    }

    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzleSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod))) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            class_replaceMethod(metacls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

static void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector){
    if (!class_isMetaClass(object_getClass(cls))) {
        return;
    }
    
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzleSelector);
    
    /* add selector if not exist, implement append with method */
    if (class_addMethod(cls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(cls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(cls,
                            swizzleSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@end
