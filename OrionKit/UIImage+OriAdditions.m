//
//  UIImage+OriAdditions.m
//  OrionKit
//
//  Created by Elvis on 2019/3/22.
//

#import "UIImage+OriAdditions.h"

@implementation UIImage (OriAdditions_Loading)

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
