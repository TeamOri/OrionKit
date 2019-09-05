//
//  OriAudioManager.h
//  OrionKit
//
//  Created by Elvis on 2019/3/29.
//

#import <Foundation/Foundation.h>

#import "OriPlayerItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface OriAudioManager : NSObject

+ (instancetype)shardInstance;

- (void)playWithPlayItem:(OriPlayerItem *)item;




@end

NS_ASSUME_NONNULL_END
