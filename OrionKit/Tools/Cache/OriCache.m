//
//  OriCache.m
//  Foundation
//
//  Created by Elvis on 2019/3/19.
//

#import "OriCache.h"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


@interface OriCache()

@property (nonatomic, strong) NSCache * coreCache;
@property (nonatomic, strong) dispatch_queue_t ioQueue;
@property (nonatomic, copy) NSString * path;

@end

@implementation OriCache

+ (instancetype)cacheWithName:(NSString *)name
{
    return [[self alloc] initWithName:name];
}

+ (instancetype)cacheWithPath:(NSString *)path
{
    return [[self alloc] initWithPath:path];
}

- (instancetype)initWithName:(NSString *)name
{
    if (name.length == 0) return nil;
    NSString * folder = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString * path = [folder stringByAppendingPathComponent:name];
    return [self initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path
{
    if (path.length == 0) return nil;
    self = [super init];
    if (self) {
        [self _configCacheWithPath:path];
    }
    return self;
}

#pragma mark - Get function.
- (BOOL)containsObjectForKey:(NSString *)key withClass:(Class)cls
{
    if (key == nil) return NO;
    id mem_result = [self.coreCache objectForKey:key];
    BOOL disk_result = NO;
    if (mem_result) {
        if ([self objectForKey:key withClass:cls]) {
            disk_result = YES;
        }
    }
    return (mem_result || disk_result);
}

- (id<NSSecureCoding>)objectForKey:(NSString *)key withClass:(Class)cls
{
    id obj = [self.coreCache objectForKey:key];
    if (obj == nil) {
        NSString * objPath = [self _getCacheFilePathForKey:key];
        if ([NSFileManager.defaultManager fileExistsAtPath:objPath]) {
            NSData * data = [[NSData alloc] initWithContentsOfFile:objPath];
            NSError * err = nil;
            @try {
                if (@available(iOS 11.0, *)) {
                    obj = [NSKeyedUnarchiver unarchivedObjectOfClass:cls fromData:data error:&err];
                } else {
                    obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
            } @catch (NSException *exception) {
                //nothing to do...
            }
            if (err) {
                NSLog(@"%s: %@",__func__,err);
            }
        }
    }
    return obj;
}

- (void)removeObjectForKey:(NSString *)key
{
    [self.coreCache removeObjectForKey:key];
    NSString * objPath = [self _getCacheFilePathForKey:key];
    if ([NSFileManager.defaultManager fileExistsAtPath:objPath]) {
        NSError * err = nil;
        [NSFileManager.defaultManager removeItemAtPath:objPath error:&err];
        if (err) {
            NSLog(@"%s: %@,Key: %@",__func__,err,key);
        }
    }
}

- (void)removeAllObjects
{
    [self.coreCache removeAllObjects];
    if ([NSFileManager.defaultManager fileExistsAtPath:self.path]) {
        NSError * err = nil;
        [NSFileManager.defaultManager removeItemAtPath:self.path error:&err];
        if (err) {
            NSLog(@"%s: %@",__func__,err);
        }
    }
}

#pragma mark - Set function.
- (void)setObject:(id<NSSecureCoding>)object forKey:(NSString *)key withClass:(Class)cls
{
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    [self.coreCache setObject:object forKey:key];
    dispatch_async(self.ioQueue, ^{
        NSError * err = nil;
        NSData * data = nil;
        if (@available(iOS 11.0, *)) {
            data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&err];
        } else {
            data = [NSKeyedArchiver archivedDataWithRootObject:object];
        }
        if (err == nil) {
            NSString * path = [self _getCacheFilePathForKey:key];
            BOOL res = [NSFileManager.defaultManager createFileAtPath:path contents:data attributes:nil];
            if (!res) {
                NSLog(@"%s ,write to file failed,Key: %@",__func__,key);
            }
        }else {
            NSLog(@"%s: %@,Key: %@",__func__,err,key);
        }
    });
}

#pragma mark - Private function.

- (void)_configCacheWithPath:(NSString *)path
{
    self.path = path;
    self.name = path.lastPathComponent;
    self.coreCache = [NSCache new];
    self.coreCache.name = self.name;
    self.ioQueue = dispatch_queue_create("com.orikit.oricache.ioqueue", DISPATCH_QUEUE_SERIAL);
    
    BOOL isDir = NO;
    if (![NSFileManager.defaultManager fileExistsAtPath:path isDirectory:&isDir]) {
        if (!isDir) {
            NSError * err = nil;
            BOOL success = [NSFileManager.defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
            if (err) {
                NSLog(@"%s :%@",__func__,err);
            }
            if (!success) {
                NSLog(@"%s, create directory fail.",__func__);
            }
        }
    }
}

- (NSString *)_getCacheFilePathForKey:(NSString *)key
{
    return [self.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.oria",key]];
}

@end
