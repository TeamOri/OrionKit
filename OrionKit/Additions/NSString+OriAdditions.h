//
//  NSString+OriAdditions.h
//  OrionKit
//
//  Created by Elvis on 2019/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OriAdditions)

/**
 获取MD5值(32Bit、大写)

 @return md5 value.
 */
- (NSString *)ori_md5;

- (nullable UIColor *)ori_color;

@end

NS_ASSUME_NONNULL_END
