//
//  UIImage+OriAdditions.h
//  OrionKit
//
//  Created by Elvis on 2019/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (OriAdditions_Loading)

/**
 通过 color 生成 纯色图.

 @param color 若为Nil 则是透明.
 @return Image实体.
 */
+ (nullable UIImage *)ori_imageWithColor:(nullable UIColor *)color;

/**
 从指定Bundle中读取图片资源.
 
 @param imageName 图片名(@"xxx.bundle").
 @param bundleName "BundleName.bundle".
 @return Image实体.
 */
+ (nullable UIImage *)ori_imageNamed:(nullable NSString *)imageName inBundleName:(nullable NSString *)bundleName;

/**
 可以读取.bundle/下的资源.

 @param imageName "xxxx.bundle/imageName"
 @return Image实体.
 */
+ (nullable UIImage *)ori_imageNamed:(nullable NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
