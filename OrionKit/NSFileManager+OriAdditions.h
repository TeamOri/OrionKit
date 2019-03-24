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

@end

NS_ASSUME_NONNULL_END
