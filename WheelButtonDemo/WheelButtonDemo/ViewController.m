//
//  ViewController.m
//  WheelButtonDemo
//
//  Created by wangyan on 2016－03－23.
//  Copyright © 2016年 Goddess. All rights reserved.
//

#import "ViewController.h"
#import "JL_WheelButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JL_WheelButton * button = [[JL_WheelButton alloc]init];
    button.frame = CGRectMake(0, 100,UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width);
    button.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
