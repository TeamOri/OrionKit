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
 从指定Bundle中读取图片资源.
 
 @param imageName 图片名(@"xxx.bundle").
 @param bundleName "BundleName.bundle".
 @return Image实体.
 */
+ (UIImage *)ori_imageNamed:(NSString *)imageName inBundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
