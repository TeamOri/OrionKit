//
//  UIImage+OriLocalized.m
//  Foundation
//
//  Created by didi on 2019/3/19.
//  Copyright © 2019 Orion. All rights reserved.
//

#import "UIImage+OriLocalized.h"

@implementation UIImage (OriLocalized)

+ (UIImage *)ori_imageNamed:(NSString *)imageName inBundleName:(NSString *)bundleName
{
    BOOL hasImageName = imageName && imageName.length > 0;
    BOOL hasBundleName= bundleName && bundleName.length > 0;
    if (hasImageName && hasBundleName) {
        NSString * path = [bundleName stringByAppendingPathComponent:imageName];
        return [UIImage imageNamed:path];
    }
    return nil;
}


@end
