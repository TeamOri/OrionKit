//
//  UIImage+OriAdditions.m
//  OrionKit
//
//  Created by Elvis on 2019/3/22.
//

#import "UIImage+OriAdditions.h"

@implementation UIImage (OriAdditions_Loading)


+ (nullable UIImage *)ori_imageWithColor:(nullable UIColor *)color
{
    color = (color?:[UIColor clearColor]);
    CGRect rect = (CGRect){0.f,0.f,1.f,1.f};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (nullable UIImage *)ori_imageNamed:(nullable NSString *)imageName inBundleName:(nullable NSString *)bundleName
{
    BOOL hasImageName = imageName && imageName.length > 0;
    BOOL hasBundleName= bundleName && bundleName.length > 0;
    if (hasImageName && hasBundleName) {
        NSString * path = [bundleName stringByAppendingPathComponent:imageName];
        return [UIImage imageNamed:path];
    }
    return nil;
}

+ (nullable UIImage *)ori_imageNamed:(NSString *)imageName
{
    UIImage * image = nil;
    if (!imageName || imageName.length == 0) return image;
    NSArray * array = [imageName componentsSeparatedByString:@"/"];
    if (array.count == 1) {
        image = [UIImage imageNamed:imageName];
    } else if (array.count >= 2) {
        NSString * bundleName = array[0];
        NSString * imageName = array.lastObject;
        if (bundleName && bundleName.length > 0 &&
            [bundleName hasSuffix:@".bundle"] &&
            imageName && imageName.length > 0) {
            image = [UIImage ori_imageNamed:imageName inBundleName:bundleName];
        } else if (imageName && imageName.length > 0) {
            image = [UIImage imageNamed:imageName];
        }
    }
    return image;
}

@end
