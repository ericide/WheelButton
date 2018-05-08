//
//  ViewController.m
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"
#import "BallPoint.h"
#import "CG3DPoint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DemoView * view = [[DemoView alloc] init];
    [self.view addSubview:view];
    
    view.frame = self.view.bounds;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGPoint location = CGPointMake(size.width/2, size.height/2);
    
    
    
    CGFloat R = MIN(location.x,location.y)  - 30;
    
    //设置起始点
    //
    
    //增加线条
    view.points = [NSMutableArray array];
    int n = 10;
    for (int j = 0; j < n; j++) {
        
        for (int i = 0; i < (n * 2); i++) {
            CGFloat phi =  i * (M_PI / n);
            BallPoint * bp = [[BallPoint alloc] initWithphi:phi theta:M_PI_2 r:R];
            CG3DPoint * originp = [[CG3DPoint alloc]init];
            
            originp.x = bp.r * sin(bp.theta) * cos(bp.phi);
            originp.y = bp.r * sin(bp.theta) * sin(bp.phi);
            originp.z = bp.r * cos(bp.theta);
            
            [view.points addObject:originp];
        }
        
        [self rollWithArray:view.points angle:M_PI / n];
        
    }
    [view setNeedsDisplay];
    
    
}

- (void)rollWithArray:(NSArray *)points angle:(CGFloat)angle {
    
    for (int i = 0; i < [points count]; i++) {
        CG3DPoint * originp =  points[i];
        CG3DPoint * resultp = [ [[DemoView alloc] init] RotateArbitraryLineWithInputPoint:originp V1:[[CG3DPoint alloc]initWithX:0 Y:0 Z:0] V2:[[CG3DPoint alloc]initWithX:1 Y:0 Z:0] angle:angle];
        originp.x = resultp.x;
        originp.y = resultp.y;
        originp.z = resultp.z;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
