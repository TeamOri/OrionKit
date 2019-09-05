//
//  OriPlayerItem.h
//  OrionKit
//
//  Created by Elvis on 2019/3/31.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface OriPlayerItem : NSObject

@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) BOOL cache;

- (instancetype)initWithURL:(NSString *)url cache:(BOOL)cache;

@end

NS_ASSUME_NONNULL_END
