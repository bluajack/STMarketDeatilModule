//
//  LBPageToolBar.h
//  GoldenTrader
//
//  Created by lsb on 15/6/9.
//  Copyright (c) 2015年 lsb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBPageToolBarDelegate <NSObject>

-(void)itemButtonClickAtIndex:(NSInteger)index;

@end


@interface LBPageToolBar : UIView

@property (nonatomic,weak) id<LBPageToolBarDelegate>delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

-(instancetype)initWithTitles:(NSArray *)titles;

@end
