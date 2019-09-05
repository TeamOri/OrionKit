//
//  OriJSONTools.h
//  OrionKit
//
//  Created by Elvis on 2019/3/22.
//  Copyright © 2019 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OriJSONTools)

/**
 JSON字符串转对象(NSArray,NSDictionary)

 @return 对象(NSArray,NSDictionary)
 */
- (nullable id)ori_objectFromJSONString;

@end

@interface NSArray (OriJSONTools)

/**
 数组转JSON字符串.

 @return JSON字符串.
 */
- (nullable NSString *)ori_JSONString;

@end

@interface NSDictionary (OriJSONTools)

/**
 字典转JSON字符串

 @return JSON字符串
 */
- (nullable NSString *)ori_JSONString;

@end

NS_ASSUME_NONNULL_END
