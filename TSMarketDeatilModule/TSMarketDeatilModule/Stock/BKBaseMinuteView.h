//
//  BKBaseMinuteView.h
//  TSMarketDeatilModule
//
//  Created byDWFutures on 2019/3/25.
//  Copyright © 2019DWFutures. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKBaseMinuteView : UIView

@property (nonatomic, strong) UIColor *stockBackGroundColor;

- (void)minuteModelWithDictionary:(NSArray<NSDictionary*> *)response;

@property (nonatomic, strong) UIView *indicatorBgView;

@end

NS_ASSUME_NONNULL_END
