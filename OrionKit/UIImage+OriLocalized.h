//
//  UIImage+OriLocalized.h
//  Foundation
//
//  Created by didi on 2019/3/19.
//  Copyright © 2019 Orion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (OriLocalized)

/**
 从指定Bundle中读取图片资源.
 
 @param imageName 图片名.
 @param bundleName "BundleName.bundle".
 @return Image实体.
 */
+ (UIImage *)ori_imageNamed:(NSString *)imageName inBundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
