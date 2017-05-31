//
//  ViewController.m
//  LFY_SecurityCodeSend_Demo
//
//  Created by Dareway on 2017/5/27.
//  Copyright © 2017年 Personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic) UILabel *sendSecurityCodeLabel;
@property (nonatomic,strong) NSTimer *timer;
@property NSInteger timerCounter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //为什么不使用UIButton，而是用UILabel，当动态改变UIButton的Title的时候，Titlte的刷新会闪烁，原因不明确
    self.sendSecurityCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 120, 32)];
    self.sendSecurityCodeLabel.font = [UIFont systemFontOfSize:13.f];
    self.sendSecurityCodeLabel.backgroundColor = [UIColor orangeColor];
    self.sendSecurityCodeLabel.textColor = [UIColor whiteColor];
    self.sendSecurityCodeLabel.text = @"发送验证码";
    [self.view addSubview:self.sendSecurityCodeLabel];
    self.sendSecurityCodeLabel.textAlignment = NSTextAlignmentCenter;
    //给UILable 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendMsgAction)];
    [self.sendSecurityCodeLabel addGestureRecognizer:tap];
    self.sendSecurityCodeLabel.userInteractionEnabled =YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMsgAction{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timerCounter = 120;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];

}

- (void)handleTimer:(id)sender{
    if (self.timerCounter <= 0) {
        //enable the sendSecurityCodeLabel button, remove the timer
        self.sendSecurityCodeLabel.userInteractionEnabled = YES;
        [self.sendSecurityCodeLabel setText:@"发送验证码"];
    }else{
        //refresh the sendSecurityCodeLabel title
        [self.sendSecurityCodeLabel setText:[NSString stringWithFormat:@"%ld秒后可重新发送",(long)self.timerCounter]];
        self.timerCounter--;
    }
}


@end
