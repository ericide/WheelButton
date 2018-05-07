//
//  BallPoint.m
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import "BallPoint.h"

@implementation BallPoint

- (instancetype)initWithphi:(CGFloat)p theta:(CGFloat)t r:(CGFloat)r
{
    self = [super init];
    self.phi = p;
    self.theta = t;
    self.r = r;
    return self;
}

@end
