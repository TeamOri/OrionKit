//
//  OriAudioManager.h
//  OrionKit
//
//  Created by Elvis on 2019/3/24.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OriAudioCoreState) {
    OriAudioCoreState_Failed             = -1,
    OriAudioCoreState_None               = 0,
    OriAudioCoreState_Unknown            = 1,
    OriAudioCoreState_ReadyToPlay        = 2,
    OriAudioCoreState_Playing            = 3,
    OriAudioCoreState_Finished           = 4,
};

@protocol OriAudioCoreDelegate;

@interface OriAudioCore : NSObject

@property (nonatomic, weak) id<OriAudioCoreDelegate> delegate;
@property (nonatomic, assign, readonly) OriAudioCoreState state;

- (void)setRate:(float)rate;

- (void)setVolume:(float)volume;

- (void)pause;

- (void)play:(AVPlayerItem *)item;

- (void)seekToTime:(CMTime)time;

/**
 获取当前音频的时间长度.

 @return 音频时长(s)
 */
- (Float64)getCurrentItemDuration;

@end


@protocol OriAudioCoreDelegate <NSObject>

/**
 音频状态更新

 @param manager Core实例.
 @param state 音频状态
 @param item PlayerItem.
 */
- (void)audioCore:(OriAudioCore *)manager onStateChange:(OriAudioCoreState)state playerItem:(AVPlayerItem *)item;

/**
 音频播放中(可获取当前播放时间)

 @param manager manager Core实例.
 @param duration 当前音频总时长.
 @param currentTime 当前音频播放的秒数.
 */
- (void)audioCore:(OriAudioCore *)manager duration:(Float64)duration currentTime:(Float64)currentTime;

/**
 中断处理回调

 @param manager Core实例.
 @param type  AVAudioSessionInterruptionType value.
 */
- (void)audioCore:(OriAudioCore *)manager intierruptionType:(AVAudioSessionInterruptionType)type;

/**
 播放设备切换

 @param manager Core实例.
 @param reason AVAudioSessionRouteChangeReason value.
 */
- (void)audioCore:(OriAudioCore *)manager routeChangeReason:(AVAudioSessionRouteChangeReason)reason;

@end

NS_ASSUME_NONNULL_END
