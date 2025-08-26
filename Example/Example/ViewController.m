//
//  ViewController.m
//  Example
//
//  Created by 覃晖 on 2019/3/20.
//  Copyright © 2019 Orion. All rights reserved.
//

#import "ViewController.h"
#import <OrionKit/NSFileManager+OriAdditions.h>

#import <OrionKit/OriAudioManager.h>


@interface ViewController ()

@property (nonatomic, strong) OriAudioManager * manager;

@property (nonatomic, strong) AVPlayerItem * item;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [OriAudioManager shardInstance];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100, 44);
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://pfile.haibian.com/paper-diyQue-audio/6cbef933-0387-4b3d-81ef-d3108d53d41e.mp3"]];
    
    
//    NSLog(@"%@",[NSFileManager ori_diskFree]);
//    NSLog(@"%llu",[NSFileManager ori_diskFree].unsignedLongLongValue);
//   NSString * str = [NSByteCountFormatter stringFromByteCount:[NSFileManager ori_diskSize].unsignedLongLongValue countStyle:NSByteCountFormatterCountStyleBinary];
//    NSLog(@"%@",str);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)click:(id)sender
{
    NSLog(@"%s",__func__);
//    [self.manager playWithPlayItem:self.item];
}

@end
