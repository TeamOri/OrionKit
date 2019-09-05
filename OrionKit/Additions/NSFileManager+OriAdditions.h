//
//  NSFileManager+OriAdditions.h
//  OrionKit
//
//  Created by Elvis on 2019/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (OriAdditions)

/**
 返回磁盘总大小

 @return 字节(bytes)[unsigned long long]
 */
+ (nonnull NSNumber *)ori_diskSize;

/**
 返回剩余磁盘的大小

 @return  字节(bytes)[unsigned long long]
 */
+ (nonnull NSNumber *)ori_diskFree;

/**
 返回指定路径文件大小

 @param path 指定路径
 @return 字节(bytes)
 */
+ (unsigned long long)ori_fileSizeAtPath:(nonnull NSString *)path;

/**
 返回指定文件夹大小

 @param path 文件夹路径
 @return 字节(bytes)
 */
+ (unsigned long long)ori_folderSizeWithPath:(nonnull NSString *)path;

/**
 指定大小是否可以保存

 @param size 指定大小
 @return 能否存储
 */
+ (BOOL)ori_isSaveDisk:(unsigned long long)size;

#pragma mark ----
/**
 获取Caches完整路径.
 
 @return 路径.
 */
+ (NSString *)ori_appTempPath;

/**
 获取Library完整路径.
 
 @return 路径.
 */
+ (NSString *)ori_appCachePath;

/**
 获取Library完整路径.
 
 @return 路径.
 */
+ (NSString *)orin_appLibraryPath;

/**
 获取Documents完整路径.
 
 @return 路径.
 */
+ (NSString *)ori_appDocumentsPath;

/**
 判断文件是否存在.
 
 @param path 文件路径字符串.
 @return 判断结果.
 */
+ (BOOL)ori_fileExistsAtPath:(nullable NSString *)path;

/**
 判断文件夹是否存在.
 
 @param path 判断文件夹是否存在
 @return 判断结果.
 */
+ (BOOL)ori_directoryExistsAtPath:(nullable NSString *)path;

/**
 创建文件夹.
 
 @param path 文件夹完整路径.
 @return 创建结果.
 */
+ (BOOL)ori_createDirectoryAtPath:(nullable NSString *)path;

/**
 删除文件或文件夹.
 
 @param filePath 文件或文件夹路径.
 @return 删除结果.
 */
+ (BOOL)ori_removeItemAtPath:(nullable NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
