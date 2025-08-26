//
//  OriCache.h
//  OrionKit
//
//  Created by Elvis on 2019/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OriCache : NSObject

@property (nonatomic, copy) NSString * name;

+ (nullable instancetype)cacheWithName:(NSString *)name;
+ (nullable instancetype)cacheWithPath:(NSString *)path;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithPath:(NSString *)path;

- (instancetype)init __attribute__((unavailable("请使用cahceWithName:初始化")));
+ (instancetype)new __attribute__((unavailable("请使用cahceWithName:初始化")));

- (BOOL)containsObjectForKey:(NSString *)key withClass:(Class)cls;
- (id<NSSecureCoding>)objectForKey:(NSString *)key withClass:(Class)cls;
- (void)setObject:(nullable id<NSSecureCoding>)object forKey:(NSString *)key withClass:(Class)cls;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;


@end

NS_ASSUME_NONNULL_END
