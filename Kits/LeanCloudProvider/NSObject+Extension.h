//
//  NSObject+Extension.h
//  MogoRenter
//
//  Created by song on 16/1/6.
//  Copyright © 2016年 MogoRoom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/**
 *  获取所有键值对
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)allPropertyAndValue;

/**
 *  获取所有属性名
 *
 *  @return <#return value description#>
 */
-(NSArray *)allProperty;

/**
 *  获取所有方法名   不包括父类  如有需要用到 以后再扩充吧
 *
 *  @return <#return value description#>
 */
-(NSArray *)allmethod;
/**
 *  获取所有属性的类型
 *
 *  @return <#return value description#>
 */
-(NSArray *)allAttribute;

/**
 *  是否包涵某个key,  可以是属性名或者是Dictionary中的键值对。当然key也可以是多层的
 *  Model1 对象叫model1    model1.model2.title   如果要查看是否可以通过Model1获取title 则此时key应该等于@"model2.title"
 *
 *  @param key 属性名或者是Dictionary中的键值对
 *  @param isContainDict 是否也包括查询字典中的key
 *
 *  @return YES:包涵  NO：不包涵
 */
-(BOOL)isContainKey:(NSString *)key isContainDictionary:(BOOL)isContainDict;


/**
 *  当上个方法等于YES调用此方法获得对应的值  注意:当上个方法为NO时返回为nil
 *
 *  @param key <#key description#>
 *  @param isContainDict 是否也包括查询字典中的key
 *
 *  @return <#return value description#>
 */
-(id)valueForContainKey:(NSString *)key isContainDictionary:(BOOL)isContainDict;

@end
