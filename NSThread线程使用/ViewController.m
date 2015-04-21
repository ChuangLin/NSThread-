//
//  ViewController.m
//  NSThread线程使用
//
//  Created by 尹晓腾 on 15/2/6.
//  Copyright (c) 2015年 bawei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDate *curDate;
    NSDate *nowDate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDidHandle:(id)sender {
    //
    curDate = [NSDate date];
    
    NSThread *thread= [[NSThread alloc] initWithTarget:self selector:@selector(getImageDataInNewThread) object:nil];
    [thread start];
}

-(void)getImageDataInNewThread
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 模拟网络延时
    [NSThread sleepForTimeInterval:8];
    UIImage *img = [UIImage imageNamed:@"10"];
    
   // 回到UI主线程中更新UI
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:img waitUntilDone:YES];
}

-(void)updateUI:(UIImage *)img
{
    self.imgView.image = img;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    nowDate = [NSDate date];
    NSTimeInterval duration = [nowDate timeIntervalSinceDate:curDate];
    NSLog(@"用时：%g",duration);

}

@end
