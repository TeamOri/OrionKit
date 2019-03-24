//
//  ViewController.m
//  Example
//
//  Created by 覃晖 on 2019/3/20.
//  Copyright © 2019 Orion. All rights reserved.
//

#import "ViewController.h"
#import <OrionKit/NSFileManager+OriAdditions.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[NSFileManager ori_diskFree]);
//    NSLog(@"%llu",[NSFileManager ori_diskFree].unsignedLongLongValue);
    
   NSString * str = [NSByteCountFormatter stringFromByteCount:[NSFileManager ori_diskSize].unsignedLongLongValue countStyle:NSByteCountFormatterCountStyleBinary];
    NSLog(@"%@",str);
    // Do any additional setup after loading the view, typically from a nib.
}


@end
