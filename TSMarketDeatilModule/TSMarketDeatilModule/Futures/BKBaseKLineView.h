//
//  BKBaseKLineView.h
//  FuturesBao
//
//  Created by blue on 2017/9/7.
//  Copyright © 2017年 lsb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKBaseKLineView : UIView

@property (nonatomic, strong) UIColor *stockBackGroundColor;

- (void)kLineModelWithDictionary:(NSArray<NSDictionary*> *)response;

@property (nonatomic, strong) UIView *indicatorBgView;

@end
