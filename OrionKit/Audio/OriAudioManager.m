//
//  OriAudioManager.m
//  OrionKit
//
//  Created by Elvis on 2019/3/29.
//

#import "OriAudioManager.h"
#import "OriAudioCore.h"

@interface OriAudioManager () <OriAudioCoreDelegate>

@property (nonatomic, strong) OriAudioCore * audioCore;

@end

@implementation OriAudioManager

+ (instancetype)shardInstance
{
    static OriAudioManager * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance =  [[OriAudioManager alloc] init];
    });
    return _instance;
}

- (void)dealloc
{
    self.audioCore = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.audioCore = [[OriAudioCore alloc] init];
        self.audioCore.delegate = self;
    }
    return self;
}

- (void)playWithPlayItem:(OriPlayerItem *)item
{
    if (!item) return;
//    [self.audioCore play:item]; 
}

#pragma mark - OriAudioCoreDelegate -

- (void)audioCore:(OriAudioCore *)manager onStateChange:(OriAudioCoreState)state playerItem:(AVPlayerItem *)item
{
    
}

- (void)audioCore:(OriAudioCore *)manager duration:(Float64)duration currentTime:(Float64)currentTime
{
    
}

- (void)audioCore:(OriAudioCore *)manager intierruptionType:(AVAudioSessionInterruptionType)type
{
    
}

- (void)audioCore:(OriAudioCore *)manager routeChangeReason:(AVAudioSessionRouteChangeReason)reason
{
    
}

@end
