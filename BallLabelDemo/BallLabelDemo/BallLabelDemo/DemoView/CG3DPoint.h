//
//  CG3DPoint.h
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CG3DPoint : NSObject
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat z;

- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
@end

@interface CG3DVector : CG3DPoint

@end
