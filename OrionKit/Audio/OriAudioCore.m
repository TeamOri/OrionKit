//
//  OriAudioManager.m
//  OrionKit
//
//  Created by Elvis on 2019/3/24.
//

#import "OriAudioCore.h"


@interface OriAudioCore ()

@property (nonatomic, strong) AVPlayer * player;

@end

@implementation OriAudioCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAudioConfig];
    }
    return self;
}

- (void)initAudioConfig
{
    self.player = [[AVPlayer alloc] init];
    _state = OriAudioCoreState_None;
    [self setVolume:1.f];
    [self setRate:1.f];
    
    //设置播放模式
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(onAudionSessionEvent:)
                                               name:AVAudioSessionInterruptionOptionKey
                                             object:session];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleRouteChange:)
                                               name:AVAudioSessionRouteChangeNotification
                                             object:session];
}

- (void)addNotificationWithPlayerItem:(AVPlayerItem *)item
{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(playbackFinished:)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:item];
}

- (void)removeNotificationWithPlayerItem:(AVPlayerItem *)item
{
    if (!item) return;
    [NSNotificationCenter.defaultCenter removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)onAudionSessionEvent:(NSNotification *)sender
{   //中断处理
    AVAudioSessionInterruptionType type = [sender.userInfo[AVAudioSessionInterruptionOptionKey] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioCore:intierruptionType:)]) {
        [self.delegate audioCore:self intierruptionType:type];
    }
}

- (void)handleRouteChange:(NSNotification *)sender
{
    AVAudioSessionRouteChangeReason reason = [sender.userInfo[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioCore:routeChangeReason:)]) {
        [self.delegate audioCore:self routeChangeReason:reason];        
//        AVAudioSessionPortHeadphones
    }
}


- (void)setRate:(float)rate
{
    if (!self.player) return;
    if (rate > 1 || rate < 0) rate = 1; //Default value.
    self.player.rate = rate;
}

- (void)setVolume:(float)volume
{
    if (!self.player) return;
    if (volume > 1 || volume < 0) volume = 1; //Default value.
    self.player.volume = volume;
}

- (void)pause
{
    if (!self.player) return;
    [self.player pause];
}

- (void)resume
{
    if (!self.player) return;
    [self.player play];
}

- (void)play:(AVPlayerItem *)item
{
    if (!self.player) return;
    if (!item) return;
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self addNotificationWithPlayerItem:item];  //监听播放完成通知
    [self addObserverWithPlayer:self.player];   //监听播放状态/加载进度(KVO)
    [self seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)seekToTime:(CMTime)time
{
    [self.player seekToTime:time
            toleranceBefore:kCMTimeZero
             toleranceAfter:kCMTimeZero];
}

- (Float64)getCurrentItemDuration
{
    if (!self.player) return 0;
    if (!self.player.currentItem) return 0;
    return [self getDurationFromPlayItem:self.player.currentItem];
}

- (void)playbackFinished:(NSNotification *)sender
{
    AVPlayerItem * item = sender.object;
    if ([self.delegate respondsToSelector:@selector(audioCore:onStateChange:playerItem:)]) {
        _state = OriAudioCoreState_Finished;
        [self.delegate audioCore:self onStateChange:_state playerItem:item];
    }
}

#pragma mark - KVO -
- (void)addObserverWithPlayer:(AVPlayer *)player
{
    if (!player) return;
    //播放状态
    [player.currentItem addObserver:self
                         forKeyPath:@"status"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    //加载情况
    [player.currentItem addObserver:self
                         forKeyPath:@"loadedTimeRanges"
                            options:NSKeyValueObservingOptionNew
                            context:nil];

    //进度状态
    __weak typeof(self) weakSelf = self;
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        self->_state = OriAudioCoreState_Playing;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(audioCore:duration:currentTime:)]) {
            Float64 duration = [strongSelf getCurrentItemDuration];
            Float64 currentTime = CMTimeGetSeconds(time);
            [strongSelf.delegate audioCore:strongSelf duration:duration currentTime:currentTime];
        }
    }];
}

- (void)removeObserverWithPlayerItem:(AVPlayerItem *)item
{
    if (!item) return;
    [item removeObserver:self forKeyPath:@"status"];
    [item removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    AVPlayerItem * item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        _state = [self getAudioStatusByAVPlayerItemStatus:status];
        BOOL canRemove = (_state == OriAudioCoreState_Failed || _state == OriAudioCoreState_Finished);
        if(canRemove) {
            [self removeObserverWithPlayerItem:item];
            [self removeNotificationWithPlayerItem:item];
        }
        if ([self.delegate respondsToSelector:@selector(audioCore:onStateChange:playerItem:)]) {
            [self.delegate audioCore:self onStateChange:_state playerItem:item];
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            //缓冲
        NSArray * array = item.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲的时间范围
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        
        
    }
}

- (Float64)getAvailableDurationFromPlayerItem:(AVPlayerItem *)item
{   //获取可播放的时间.
    Float64 result = 0;
    if (!item) return result;
    CMTimeRange timeRange = item.loadedTimeRanges.firstObject.CMTimeRangeValue;
    Float64 startSecond = CMTimeGetSeconds(timeRange.start);
    Float64 durationSeconds = CMTimeGetSeconds(timeRange.duration);
    result = startSecond + durationSeconds;
    return result;
}

- (Float64)getDurationFromPlayItem:(AVPlayerItem *)item
{   //获取音频总时间
    Float64 duration = 0;
    if (!item) return duration;
    duration = item.duration.value / item.duration.timescale;
    return duration;
}

- (OriAudioCoreState)getAudioStatusByAVPlayerItemStatus:(AVPlayerItemStatus)avStatus
{   //将 AVPlayerItemStatus 转换成 OriAudioState
    OriAudioCoreState audioStatus = OriAudioCoreState_None;
    switch (avStatus) {
        case AVPlayerItemStatusUnknown:
            audioStatus = OriAudioCoreState_Unknown;
            break;
        case AVPlayerItemStatusReadyToPlay:
            audioStatus = OriAudioCoreState_ReadyToPlay;
            [self.player play];
            break;
        case AVPlayerItemStatusFailed:
            audioStatus = OriAudioCoreState_Failed;
            break;
        default:
            audioStatus = OriAudioCoreState_Unknown;
            break;
    }
    return audioStatus;
}

+ (NSString *)conversionTimeBySecond:(NSTimeInterval)second
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSString * dateFormat = second/(60*60) >= 1?@"HH:mm:ss":@"mm:ss";
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:date];
}

@end
