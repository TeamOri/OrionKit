//
//  NSString+OriAdditions.m
//  OrionKit
//
//  Created by Elvis on 2019/9/9.
//

#import "NSString+OriAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (OriAdditions)

- (NSString *)ori_md5
{
    const char * cStr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString * md5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [md5Str appendFormat:@"%02x", digest[i]];
    return md5Str;
}

- (nullable UIColor *)ori_color
{
    NSString * colorStr = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].uppercaseString;
    if (self.length < 6) return nil;
    if ([colorStr hasPrefix:@"0X"]) {
        colorStr = [colorStr substringFromIndex:2];
    }else if ([colorStr hasPrefix:@"#"]) {
        colorStr = [colorStr substringFromIndex:1];
    }
    if (colorStr.length != 6) return nil;
    NSRange range = NSMakeRange(0, 2);
    NSString * rStr = [self substringWithRange:range];
    range.location += 2;
    NSString * gStr = [self substringWithRange:range];
    range.location += 2;
    NSString * bStr = [self substringWithRange:range];
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    return [UIColor colorWithRed:(r/255.f) green:(g/255.f) blue:(b/255.f) alpha:1.f];
}

@end
