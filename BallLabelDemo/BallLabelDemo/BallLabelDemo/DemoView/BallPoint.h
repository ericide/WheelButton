//
//  BallPoint.h
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallPoint : NSObject
@property (nonatomic,assign) CGFloat theta;
@property (nonatomic,assign) CGFloat phi;
@property (nonatomic,assign) CGFloat r;

- (instancetype)initWithphi:(CGFloat)p theta:(CGFloat)t r:(CGFloat)r;
@end
