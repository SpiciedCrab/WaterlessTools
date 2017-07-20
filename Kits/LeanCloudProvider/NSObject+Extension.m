//
//  NSObject+Extension.m
//  MogoRenter
//
//  Created by song on 16/1/6.
//  Copyright © 2016年 MogoRoom. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)

-(NSArray *)allProperty{
    NSMutableArray *mArr = [NSMutableArray array];
    return [self allPropertyFromSelfAndSuper:mArr ForClass:[self class]].copy;
}

-(NSDictionary *)allPropertyAndValue{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    return [self allPropertyAndValueFromSelfAndSuper:mDict ForClass:[self class]].copy;
}

-(NSArray *)allPropertyFromSelfAndSuper:(NSMutableArray *)mArr ForClass:(Class)aclass{
    
    if ([NSStringFromClass(aclass) isEqualToString:@"NSObject"]) {
        return mArr;
    }else{
        // 获取当前类的所有属性
        unsigned int count;// 记录属性个数
        objc_property_t *properties = class_copyPropertyList(aclass, &count);
        // 遍历
        for (int i = 0; i < count; i++) {
            
            // An opaque type that represents an Objective-C declared property.
            // objc_property_t 属性类型
            objc_property_t property = properties[i];
            // 获取属性的名称 C语言字符串
            const char *cName = property_getName(property);
            // 转换为Objective C 字符串
            NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            [mArr addObject:name];
        }
        return [self allPropertyFromSelfAndSuper:mArr ForClass:aclass.superclass];
    }
}


-(NSDictionary *)allPropertyAndValueFromSelfAndSuper:(NSMutableDictionary *)mDict ForClass:(Class)aclass{
    
    if ([NSStringFromClass(aclass) isEqualToString:@"NSObject"]) {
        return mDict;
    }else{
        // 获取当前类的所有属性
        unsigned int count;// 记录属性个数
        objc_property_t *properties = class_copyPropertyList(aclass, &count);
        // 遍历
        for (int i = 0; i < count; i++) {
            
            // An opaque type that represents an Objective-C declared property.
            // objc_property_t 属性类型
            objc_property_t property = properties[i];
            // 获取属性的名称 C语言字符串
            const char *cName = property_getName(property);
            // 转换为Objective C 字符串
            NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            [mDict setValue:[self valueForKey:name] forKey:name];
        }
        return [self allPropertyAndValueFromSelfAndSuper:mDict ForClass:aclass.superclass];
    }
}


-(NSArray *)allmethod{
    unsigned int count;
    
    Method *methods = class_copyMethodList([self class], &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++){
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        [mArray addObject:name];
    }
    return mArray.copy;
}

-(NSArray *)allAttribute{
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char * attributes = property_getAttributes(property);//获取属性类型
        // 转换为Objective C 字符串
        NSString *attribute = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        [mArray addObject:attribute];
    }
    
    return mArray.copy;
}

-(BOOL)isContainKey:(NSString *)key isContainDictionary:(BOOL)isContainDict{
    NSMutableArray *keys = [NSMutableArray arrayWithArray:[key componentsSeparatedByString:@"."]];
    return  [self isContainKeys:keys isContainDictionary:isContainDict forObject:self];
}

-(BOOL)isContainKeys:(NSMutableArray *)keys isContainDictionary:(BOOL)isContainDict forObject:(NSObject *)obj{
    NSArray *objPropertiesOrKeys;
    if ([obj isKindOfClass:[NSDictionary class]] && isContainDict)
    {
        objPropertiesOrKeys = ((NSDictionary *)obj).allKeys;
    }
    else
    {
        objPropertiesOrKeys = [obj allProperty]; //获得所有属性名
    }
    if (keys.count > 0)
    {
         __block NSString *currentKey = keys[0];
        __weak typeof(obj) Obj = obj;
        [objPropertiesOrKeys enumerateObjectsUsingBlock:^(NSString *indeKey, NSUInteger idx, BOOL *stop) {
            
            if ([indeKey isEqualToString:currentKey])
            {
                [keys removeObjectAtIndex:0];
                if (keys.count == 0)
                {
                    *stop = YES;
                }
                else
                {
                    [self isContainKeys:keys isContainDictionary:isContainDict forObject:[Obj valueForKey:indeKey]];
                }
            }
        }];
    }
    if (keys.count == 0)
    {
        return YES;
    }
    
    return NO;
}


-(id)valueForContainKey:(NSString *)key isContainDictionary:(BOOL)isContainDict{
    if ([self isContainKey:key isContainDictionary:isContainDict])
    {
        return [self valueForKeyPath:key];
    }
    else
        return nil;
}

@end
