//
//  ViewController.m
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DemoView * view = [[DemoView alloc] init];
    [self.view addSubview:view];
    
    view.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
