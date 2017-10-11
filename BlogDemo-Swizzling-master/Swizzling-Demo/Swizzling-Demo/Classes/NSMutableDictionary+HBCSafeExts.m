//
//  NSMutableDictionary+HBCSafeExts.m
//  HBCRouter
//
//  Created by heke on 2016/11/16.
//  Copyright © 2016年 皇包车. All rights reserved.
//

#import "NSMutableDictionary+HBCSafeExts.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (HBCSafeExts)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKeyedSubscript:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(load_setObject:forKeyedSubscript:));
    method_exchangeImplementations(fromMethod, toMethod);
    
    Method fromMethod_1 = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method toMethod_1 = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(load_setObject:forKey:));
    method_exchangeImplementations(fromMethod_1, toMethod_1);
}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (void)load_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (anObject == nil || aKey == nil) {
        @try {
            [self load_setObject:anObject forKeyedSubscript:aKey];
        }
        @catch (NSException *exception) {
            NSLog(@"object and key mustn't be null when do insert op");
        }
        @finally {}
    } // 如果没有问题，则正常进行方法调用
    else {
        [self load_setObject:anObject forKeyedSubscript:aKey];
    }
}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (void)load_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (anObject == nil || aKey == nil) {
        @try {
            [self load_setObject:anObject forKey:aKey];
        }
        @catch (NSException *exception) {
            NSLog(@"object and key mustn't be null when do insert op");
        }
        @finally {}
    } // 如果没有问题，则正常进行方法调用
    else {
        [self load_setObject:anObject forKey:aKey];
    }
}

@end
