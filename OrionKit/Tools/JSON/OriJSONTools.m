//
//  OriJSONTools.m
//  OrionKit
//
//  Created by Elvis on 2019/3/22.
//  Copyright © 2019 Elvis. All rights reserved.
//

#import "OriJSONTools.h"

#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


@interface OriPublicJSONTools: NSObject @end
@implementation OriPublicJSONTools

+ (nullable NSString *)_ori_toJSON:(id)jsonObject
{
    NSError * err = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&err];
    if (!err) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"%s:%@",__func__,err);
    return nil;
}

@end

@implementation NSString (OriJSONTools)

- (nullable id)ori_objectFromJSONString
{
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&err];
    if (err) {
        NSLog(@"%s:%@",__func__,err);
    }
    return object;
}

@end

@implementation NSArray (OriJSONTools)

- (nullable NSString *)ori_JSONString
{
    return [OriPublicJSONTools _ori_toJSON:self];
}

@end

@implementation NSDictionary (OriJSONTools)

- (nullable NSString *)ori_JSONString
{
    return [OriPublicJSONTools _ori_toJSON:self];
}

@end
