//
//  NSFileManager+OriTools.m
//  OrionKit
//
//  Created by Elvis on 2019/4/26.
//

#import "NSFileManager+OriTools.h"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

@implementation NSFileManager (OriTools)

+ (NSString *)ori_appTempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)ori_appCachePath
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)orin_appLibraryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)ori_appDocumentsPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (BOOL)ori_fileExistsAtPath:(nullable NSString *)path
{
    if (path == nil) return NO;
    BOOL isDirectory = NO;
    NSFileManager * fileMgr = NSFileManager.defaultManager;
    if ([fileMgr fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (!isDirectory) return YES;
    }
    return NO;
}

+ (BOOL)ori_directoryExistsAtPath:(nullable NSString *)path
{
    if (path == nil) return NO;
    BOOL isDirectory = NO;
    NSFileManager * fileMgr = NSFileManager.defaultManager;
    if ([fileMgr fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) return YES;
    }
    return NO;
}

+ (BOOL)ori_createDirectoryAtPath:(NSString *)path
{
    if (path == nil) return NO;
    if ([self ori_directoryExistsAtPath:path]) return NO;
    NSError * err = nil;
    NSFileManager * fileMgr = NSFileManager.defaultManager;
    BOOL created = [fileMgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
    NSLog(@"%s:%@",__func__,err);
    return created;
}

+ (BOOL)ori_removeItemAtPath:(nullable NSString *)path
{
    if (path == nil) return NO;
    NSError * err = nil;
    BOOL results = NO;
    NSFileManager * fileMgr = NSFileManager.defaultManager;
    if ([fileMgr fileExistsAtPath:path]) {
        results = [fileMgr removeItemAtPath:path error:&err];
    }
    NSLog(@"%s:%@",__func__,err);
    return results;
}

@end
