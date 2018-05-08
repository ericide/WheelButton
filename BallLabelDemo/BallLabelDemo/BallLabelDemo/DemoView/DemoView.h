//
//  DemoView.h
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallPoint.h"
#import "CG3DPoint.h"

@interface DemoView : UIView
@property (nonatomic,strong)  NSMutableArray * points;

- (CG3DPoint *)RotateArbitraryLineWithInputPoint:(CG3DPoint *)inp V1:(CG3DPoint*) v1 V2:(CG3DPoint*) v2 angle:(float)theta;
@end
