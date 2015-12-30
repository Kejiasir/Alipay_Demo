//
//  NSObject+Log.m
//  Alipay_Demo
//
//  Created by Arvin on 15/12/15.
//  Copyright © 2015年 Arvin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSObject+Log.h"
#import <objc/runtime.h>

@implementation NSObject (Log)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([NSObject class], @selector(description)), class_getInstanceMethod([NSObject class], @selector(YYDescription)));
}

/**
 *  自定义模型(继承NSObject)的输出格式
 *  @return 返回格式化后的字符串
 */
- (NSString *)YYDescription {
    Class class = [self class];
    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%@ = {\n",[self YYDescription]];
    while (class != [NSObject class]) {
        if ([[class description] hasPrefix:@"NS"] || [[class description] hasPrefix:@"__"]|| [[class description] hasPrefix:@"AV"] || [[class description] hasPrefix:@"_UIFlowLayout"] || [[class description] hasPrefix:@"UITouchesEvent"] || [class isSubclassOfClass:[UIResponder class]] || [class isSubclassOfClass:[CALayer class]] || [class isSubclassOfClass:[UIImage class]])return [self YYDescription];
        unsigned int count = 0;
        Ivar *vars = class_copyIvarList(class, &count);
        for (int index = 0; index < count; index ++) {
            Ivar var = vars[index];
            const char *name = ivar_getName(var);
            NSString *varName = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:varName];
            [resultStr appendFormat:@"\t%@ = %@;\n", varName, value];
        }
        free(vars);
        class = class_getSuperclass(class);
    }
    [resultStr appendString:@"}\n"];
    return resultStr;
}
@end

/*=======================华༗丽༗丽༗的༗分༗🈹༗线༗=======================*/
@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str_M = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str_M appendFormat:@"\t%@,\n", obj];
    }];
    [str_M appendString:@")"];
    return str_M;
}
@end

/*=======================华༗丽༗丽༗的༗分༗🈹༗线༗=======================*/
@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str_M = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str_M appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [str_M appendString:@"}\n"];
    return str_M;
}
@end

