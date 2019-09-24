//
//  UILineView.m
//  GoldenTrader
//
//  Created by lsb on 15/6/1.
//  Copyright (c) 2015年 lsb. All rights reserved.
//

#import "UILineView.h"
#import "ColorMacro.h"

@implementation UILineView

-(id)init{
    self=[super init];
    if (self) {
       // self.backgroundColor = RGB(230, 230, 230);
        self.translatesAutoresizingMaskIntoConstraints=NO;
        CALayer *line = [CALayer layer];
        line.backgroundColor = RGB(230, 230, 230).CGColor;
        line.frame = CGRectMake(0, 0, 0, 1/[UIScreen mainScreen].scale);
        [self.layer addSublayer:line];
    }
    return self;
}
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    CALayer *line = [[self.layer sublayers] firstObject];
    line.backgroundColor  = _lineColor.CGColor;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CALayer *line = [[self.layer sublayers] firstObject];
    CGRect frame = self.bounds;
    frame.size.height = 1/[UIScreen mainScreen].scale;
    line.frame = frame;
}
@end
