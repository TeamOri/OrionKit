//
//  NSFileManager+OriTools.h
//  OrionKit
//
//  Created by Elvis on 2019/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (OriTools)

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
