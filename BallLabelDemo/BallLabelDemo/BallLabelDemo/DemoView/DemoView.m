//
//  DemoView.m
//  BallLabelDemo
//
//  Created by Win10 on 2018/5/7.
//  Copyright © 2018年 Win10. All rights reserved.
//

#import "DemoView.h"


@interface DemoView()

@property (nonatomic,strong) UITouch * startPoint;
@property (nonatomic,assign) CGFloat arfa;




@end
@implementation DemoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.points = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.startPoint = touches.allObjects.lastObject;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGPoint location = CGPointMake(size.width/2, size.height/2);
    CGFloat R = MIN(location.x,location.y)  - 30;
    
    UITouch * currentTouch = touches.allObjects.lastObject;
    CGPoint currentPoint = [currentTouch locationInView:self];
    CGPoint lastPoint = [currentTouch previousLocationInView:self];
    //    NSLog(@"%@%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(lastPoint));
    CGVector userTrail = CGVectorMake(currentPoint.x - lastPoint.x,currentPoint.y - lastPoint.y);
    CGVector tangent = CGVectorMake( lastPoint.y - currentPoint.y ,currentPoint.x - lastPoint.x);
    

    CGFloat angle = atan(sqrt(pow(userTrail.dx,2) + pow(userTrail.dy,2)) / R);
    [self rollWithArrow:tangent angle:angle];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch * currentTouch = touches.allObjects.lastObject;
//    CGPoint currentPoint = [currentTouch locationInView:self];
//    CGPoint lastPoint = [currentTouch previousLocationInView:self];
//    NSLog(@"%@%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(lastPoint));
//
//    CGVector userTrail = CGVectorMake(currentPoint.x - lastPoint.x,currentPoint.y - lastPoint.y);
//    CGVector tangent = CGVectorMake(  self.bounds.size.height / 2 - lastPoint.y, lastPoint.x - self.bounds.size.width / 2);//切线：圆上的点与圆心的向量，xy颠倒后，x取负数
//
//    CGFloat off = (userTrail.dx * tangent.dx + userTrail.dy * tangent.dy) / (sqrt(pow(tangent.dx,2) + pow(tangent.dy,2))) ;
//
//    CGFloat theta = (off / sqrt(pow(tangent.dx,2) + pow(tangent.dy,2)));
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        CGFloat s = theta;
//
//        NSInteger num = abs((int)(theta / 0.005));
//        CGFloat shuai = theta / num;
//        for (int i = 0; i < num; i ++) {
//            [NSThread sleepForTimeInterval:0.008];
//            s = s - shuai;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.arfa += s;
//                [self layoutSubviews];
//            });
//        }
//    });
}

- (void)rollWithArrow:(CGVector)vector angle:(CGFloat)angle {
    
    if (fabs(vector.dx) < 0.00001 && fabs(vector.dy) < 0.00001) {
        NSLog(@"%@",NSStringFromCGVector(vector));
        return;
    }
    
    for (int i = 0; i < [self.points count]; i++) {
        CG3DPoint * originp =  self.points[i];
        CG3DPoint * resultp = [self RotateArbitraryLineWithInputPoint:originp V1:[[CG3DPoint alloc]initWithX:0 Y:0 Z:0] V2:[[CG3DPoint alloc]initWithX:vector.dx Y:vector.dy Z:0] angle:angle];
        originp.x = resultp.x;
        originp.y = resultp.y;
        originp.z = resultp.z;
    }
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    
    
    [super drawRect:rect];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGPoint location = CGPointMake(size.width/2, size.height/2);
    
    for (int i = 0; i < [self.points count]; i++) {
        CG3DPoint * resultp =  self.points[i];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth     = 5.0f;              //设置线条宽度
        path.lineCapStyle  = kCGLineCapRound;   //设置拐角
        path.lineJoinStyle = kCGLineCapRound;  //终点处理
        
        [path moveToPoint:CGPointMake(resultp.x + location.x,resultp.y + location.y)];
        [path addLineToPoint:CGPointMake(resultp.x + location.x,resultp.y + location.y)];
        
        CGFloat length =  sqrt( pow(resultp.x, 2) + pow(resultp.y, 2) + pow(resultp.z, 2) );
        
        UIColor *color = [UIColor colorWithRed:(resultp.z / length + 1)/2.0 green:(resultp.z / length + 1)/2.0 blue:0 alpha:1];
        [color set];
        [path closePath];
        [path stroke];
    }
}
- (void)D3DXVec3Normalize:(CG3DVector *)p
{
    CGFloat m =  sqrt( pow(p.x, 2) + pow(p.y, 2) + pow(p.z, 2) );
    p.x = p.x / m;
    p.y = p.y / m;
    p.z = p.z / m;
}

- (CG3DPoint *)RotateArbitraryLineWithInputPoint:(CG3DPoint *)inp V1:(CG3DPoint*) v1 V2:(CG3DPoint*) v2 angle:(float)theta
{

    float a = v1.x;
    float b = v1.y;
    float c = v1.z;
    
    CG3DVector * p = [[CG3DVector alloc]initWithX:(v2.x - v1.x) Y:(v2.y - v1.y) Z:(v2.z - v1.z)];
    
    [self D3DXVec3Normalize:p];
    
    float u = p.x;
    float v = p.y;
    float w = p.z;
    
    float uu = u * u;
    float uv = u * v;
    float uw = u * w;
    float vv = v * v;
    float vw = v * w;
    float ww = w * w;
    float au = a * u;
    float av = a * v;
    float aw = a * w;
    float bu = b * u;
    float bv = b * v;
    float bw = b * w;
    float cu = c * u;
    float cv = c * v;
    float cw = c * w;
    
    float costheta = cos(theta);
    float sintheta = sin(theta);
    
    double m[4][4];
    
    m[0][0] = uu + (vv + ww) * costheta;
    m[0][1] = uv * (1 - costheta) + w * sintheta;
    m[0][2] = uw * (1 - costheta) - v * sintheta;
    m[0][3] = 0;
    
    m[1][0] = uv * (1 - costheta) - w * sintheta;
    m[1][1] = vv + (uu + ww) * costheta;
    m[1][2] = vw * (1 - costheta) + u * sintheta;
    m[1][3] = 0;
    
    m[2][0] = uw * (1 - costheta) + v * sintheta;
    m[2][1] = vw * (1 - costheta) - u * sintheta;
    m[2][2] = ww + (uu + vv) * costheta;
    m[2][3] = 0;
    
    m[3][0] = (a * (vv + ww) - u * (bv + cw)) * (1 - costheta) + (bw - cv) * sintheta;
    m[3][1] = (b * (uu + ww) - v * (au + cw)) * (1 - costheta) + (cu - aw) * sintheta;
    m[3][2] = (c * (uu + vv) - w * (au + bv)) * (1 - costheta) + (av - bu) * sintheta;
    m[3][3] = 1;
    
    CG3DPoint * outp = [[CG3DPoint alloc]init];
    outp.x = m[0][0] * inp.x + m[1][0] * inp.y +m[2][0] * inp.z + m[3][0];
    outp.y = m[0][1] * inp.x + m[1][1] * inp.y +m[2][1] * inp.z + m[3][1];
    outp.z = m[0][2] * inp.x + m[1][2] * inp.y +m[2][2] * inp.z + m[3][2];
    return outp;
}

@end
