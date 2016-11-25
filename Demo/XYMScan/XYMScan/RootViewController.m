//
//  RootViewController.m
//  XYMScan
//
//  Created by jack xu on 16/11/17.
//  Copyright © 2016年 jack xu. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "RootViewController.h"
#import "XYMScanViewController.h"
#import "XYMGuideView.h"

@interface RootViewController ()<XYMGuideViewDelegate>


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 40);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"开始扫码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    CGPoint point = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
    
    //新手指引蒙层
    XYMGuideView *guideView = [[XYMGuideView alloc]init];
    guideView.guideName = @"hello";
    guideView.delegate = self;
    [guideView setCircularFocus:point radius:60];
    
    //显示引导信息的View（自定义）
    UIView *tipsView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.5, ScreenHeight * 0.5 + 60, 100, 50)];
    tipsView.backgroundColor = [UIColor yellowColor];
    
    [guideView addTipsView:tipsView];
    
    [self.view addSubview:guideView];
}


-(void)startScan{
    
    XYMScanViewController *scanView = [[XYMScanViewController alloc]init];

    [self.navigationController pushViewController:scanView animated:YES];
}

-(void)XYMGuideClick:(NSString*)guideName{

    NSLog(@"%@",guideName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
