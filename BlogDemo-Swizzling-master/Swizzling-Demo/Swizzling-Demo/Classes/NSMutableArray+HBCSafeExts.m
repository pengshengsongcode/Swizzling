//
//  NSMutableArray+HBCSafeExts.m
//  HBCRouter
//
//  Created by heke on 2016/11/16.
//  Copyright © 2016年 皇包车. All rights reserved.
//

#import "NSMutableArray+HBCSafeExts.h"
#import <objc/runtime.h>

@implementation NSMutableArray (HBCSafeExts)


// Swizzling核心代码
// 需要注意的是，好多同学反馈下面代码不起作用，造成这个问题的原因大多都是其调用了super load方法。在下面的load方法中，不应该调用父类的load方法。
+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(addObject:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(load_addObject:));
    method_exchangeImplementations(fromMethod, toMethod);
}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (void)load_addObject:(nonnull id)anObject {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (anObject == nil) {
        @try {
            [self load_addObject:anObject];
        }
        @catch (NSException *exception) {

        }
        @finally {}
    } // 如果没有问题，则正常进行方法调用
    else {
        [self load_addObject:anObject];
    }
}

@end
