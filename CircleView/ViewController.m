//
//  ViewController.m
//  CircleView
//
//  Created by Dahao Jiang on 2018/8/7.
//  Copyright © 2018年 Dahao Jiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:[touch view]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    [self addAnimateView:view point:point];
}

//TODO::
- (void)addAnimateView:(UIView *)view point:(CGPoint)point {
    
    float width = view.frame.size.width;
    float height = view.frame.size.height;
    
    float corner = (width > height) ? height : width;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CAKeyframeAnimation *animate1 = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    NSMutableArray *values1 = [NSMutableArray array];
    
    
    for (int i = 0; i <= 10; i ++) {
        NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, 0, width/10 * i, height/10 * i)];
        [values1 addObject:value];
    }
    animate1.values = values1;
    animate1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *animate2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSMutableArray *values2 = [NSMutableArray array];
    for (int i = 0; i <= 10; i ++) {
        CGPoint center = self.view.center;
        float x = (center.x - point.x) / 10;
        float y = (center.y - point.y) / 10;
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(point.x + x * i, point.y + y * i)];
        [values2 addObject:value];
    }
    animate2.values = values2;
    animate2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *animate3 = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    NSMutableArray *values3 = [NSMutableArray array];
    for (int i = 0; i <= 10; i ++) {
        NSNumber *num = @(corner * (1- i/10));;
        [values3 addObject:num];
    }
    animate3.values = values3;
    animate3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    group.animations = @[animate1,animate2,animate3];
    group.repeatCount = 1;
    group.duration = 0.8;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:group forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
