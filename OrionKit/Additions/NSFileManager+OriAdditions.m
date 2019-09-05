//
//  NSFileManager+OriAdditions.m
//  OrionKit
//
//  Created by Elvis on 2019/3/23.
//

#import "NSFileManager+OriAdditions.h"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

@implementation NSFileManager (OriAdditions)

+ (NSNumber *)ori_diskSize
{
    NSError * err = nil;
    NSDictionary * sysAttributes = [NSFileManager.defaultManager attributesOfFileSystemForPath:NSHomeDirectory() error:&err];
    if (err) return @(0);
    return [sysAttributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)ori_diskFree
{
    NSError * err = nil;
    NSDictionary * sysAttributes = [NSFileManager.defaultManager attributesOfFileSystemForPath:NSHomeDirectory() error:&err];
    if (err) return @(0);
    return [sysAttributes objectForKey:NSFileSystemFreeSize];
}

+ (unsigned long long)ori_fileSizeAtPath:(nonnull NSString *)path
{
    if ([NSFileManager.defaultManager fileExistsAtPath:path]) {
        return [NSFileManager.defaultManager attributesOfItemAtPath:path error:nil].fileSize;
    }
    return 0;
}

+ (unsigned long long)ori_folderSizeWithPath:(nonnull NSString *)path
{
    unsigned long long folderSize = 0;
    NSFileManager * manager = NSFileManager.defaultManager;
    BOOL isFolder = NO;
    if (![manager fileExistsAtPath:path isDirectory:&isFolder]) return folderSize;
    if (!isFolder) return folderSize;
    NSEnumerator * filesEnumerator = [manager subpathsAtPath:path].objectEnumerator;
    NSString * fileName = nil;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString * fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [NSFileManager ori_fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

+ (BOOL)ori_isSaveDisk:(unsigned long long)size
{
    return [self ori_diskFree].unsignedLongLongValue - size > 0;
}

#pragma mark ----

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
