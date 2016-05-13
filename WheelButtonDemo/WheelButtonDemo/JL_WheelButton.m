//
//  JL_WheelButton.m
//  WheelButtonDemo
//
//  Created by wangyan on 2016－03－23.
//  Copyright © 2016年 Goddess. All rights reserved.
//

#import "JL_WheelButton.h"
@interface JL_WheelButton()
@property (nonatomic,strong) NSMutableArray <JL_WheelItem *>* bSet;
@property (nonatomic,strong) UITouch * startPoint;
@property (nonatomic,assign) CGFloat arfa;
@end
@implementation JL_WheelButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    for (int i = 0; i < 8; i++) {
        JL_WheelItem * btn = [JL_WheelItem buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"demo"] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.frame = CGRectMake(0, 0, 100, 100);
        [self.bSet addObject:btn];
    }
}
- (void)layoutSubviews
{
    CGFloat sideLength = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius = sideLength / 2 - 40;
//    self.arfa = M_PI * 0.1;
    for (int i = 0; i < 8; i++){
        CGFloat theta = (M_PI / 4) * i + self.arfa;
        CGFloat x = self.bounds.size.width / 2 + radius * sin(theta);
        CGFloat y = self.bounds.size.height / 2 - radius * cos(theta);
        self.bSet[i].center = CGPointMake(x, y);
    }
}

- (NSMutableArray *)bSet
{
    if (!_bSet) {
        _bSet = [NSMutableArray array];
    }
    return _bSet;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%@",NSStringFromCGPoint(point));
//    return NO;
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.startPoint = touches.allObjects.lastObject;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * currentTouch = touches.allObjects.lastObject;
    CGPoint currentPoint = [currentTouch locationInView:self];
    CGPoint lastPoint = [currentTouch previousLocationInView:self];
//    NSLog(@"%@%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(lastPoint));
    
    CGVector userTrail = CGVectorMake(currentPoint.x - lastPoint.x,currentPoint.y - lastPoint.y);
    CGVector tangent = CGVectorMake(  self.bounds.size.height / 2 - lastPoint.y, lastPoint.x - self.bounds.size.width / 2);//切线：圆上的点与圆心的向量，xy颠倒后，x取负数
    
    CGFloat off = (userTrail.dx * tangent.dx + userTrail.dy * tangent.dy) / (sqrt(pow(tangent.dx,2) + pow(tangent.dy,2))) ;
    
    self.arfa += (off / sqrt(pow(tangent.dx,2) + pow(tangent.dy,2)));
    [self layoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * currentTouch = touches.allObjects.lastObject;
    CGPoint currentPoint = [currentTouch locationInView:self];
    CGPoint lastPoint = [currentTouch previousLocationInView:self];
    NSLog(@"%@%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(lastPoint));
    
    CGVector userTrail = CGVectorMake(currentPoint.x - lastPoint.x,currentPoint.y - lastPoint.y);
    CGVector tangent = CGVectorMake(  self.bounds.size.height / 2 - lastPoint.y, lastPoint.x - self.bounds.size.width / 2);//切线：圆上的点与圆心的向量，xy颠倒后，x取负数
    
    CGFloat off = (userTrail.dx * tangent.dx + userTrail.dy * tangent.dy) / (sqrt(pow(tangent.dx,2) + pow(tangent.dy,2))) ;
    
    CGFloat theta = (off / sqrt(pow(tangent.dx,2) + pow(tangent.dy,2)));
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat s = theta;
        
        NSInteger num = abs((int)(theta / 0.005));
        CGFloat shuai = theta / num;
        for (int i = 0; i < num; i ++) {
            [NSThread sleepForTimeInterval:0.008];
            s = s - shuai;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.arfa += s;
                [self layoutSubviews];
            });
        }
    });
}
@end
@implementation JL_WheelItem
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}
@end