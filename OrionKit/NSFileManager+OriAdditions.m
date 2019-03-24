//
//  NSFileManager+OriAdditions.m
//  OrionKit
//
//  Created by Elvis on 2019/3/23.
//

#import "NSFileManager+OriAdditions.h"

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

@end
