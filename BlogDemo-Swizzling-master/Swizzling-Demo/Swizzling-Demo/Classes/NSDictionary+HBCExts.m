//
//  NSDictionary+HBCExts.m
//  HBCRouter
//
//  Created by heke on 2016/11/16.
//  Copyright © 2016年 皇包车. All rights reserved.
//

#import "NSDictionary+HBCExts.h"
#import <objc/runtime.h>

@implementation NSDictionary (HBCExts)

- (NSString *)hbc_JSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error != nil) {
            NSLog(@"Json Serialize error:%@,jsonObject:%@",error,self);
            return nil;
        }
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

@end
