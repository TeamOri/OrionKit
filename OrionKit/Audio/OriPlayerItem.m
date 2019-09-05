//
//  OriPlayerItem.m
//  OrionKit
//
//  Created by Elvis on 2019/3/31.
//

#import "OriPlayerItem.h"


@interface OriPlayerItem ()



@end

@implementation OriPlayerItem

- (instancetype)initWithURL:(NSString *)url cache:(BOOL)cache
{
    self = [super init];
    if (self) {
        self.url = url;
        self.cache = cache;
    }
    return self;
}

@end
