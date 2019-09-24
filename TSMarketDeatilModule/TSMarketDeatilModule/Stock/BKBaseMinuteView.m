//
//  BKBaseMinuteView.m
//  TSMarketDeatilModule
//
//  Created byDWFutures on 2019/3/25.
//  Copyright © 2019DWFutures. All rights reserved.
//

#import "BKBaseMinuteView.h"
#import <Masonry/Masonry.h>

#import "YYStockConstant.h"
#import "YYStockView_TimeLine.h"
#import "UIColor+YYStockTheme.h"
#import "YYStockViewMaskView.h"
#import "YYStockVariable.h"
#import "YYTimeLineModel.h"
#import "YYStockView_Kline.h"

@interface BKBaseMinuteView ()<YYStockViewTimeLinePressProtocol>

@property (nonatomic, strong) YYStockView_TimeLine *stockView;

/**
 长按时出现的遮罩View
 */
@property (nonatomic, strong) YYStockViewMaskView *maskView;

@end

@implementation BKBaseMinuteView

- (void)setStockBackGroundColor:(UIColor *)stockBackGroundColor {
    _stockBackGroundColor = stockBackGroundColor;
    _stockView.backgroundColor = stockBackGroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _stockView =  [[YYStockView_TimeLine alloc]initWithTimeLineModels:nil isShowFiveRecord: NO fiveRecordModel:nil];
    _stockView.delegate = self;
    _stockView.backgroundColor = [UIColor YYStock_bgColor];
    [self addSubview:_stockView];
    [_stockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    _indicatorBgView = [UIView new];
    _indicatorBgView.backgroundColor = [UIColor YYStock_bgColor];
    [self addSubview:_indicatorBgView];
    [_indicatorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_indicatorBgView addSubview:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [indicator startAnimating];
}

- (void)minuteModelWithDictionary:(NSArray<NSDictionary*> *)response {
    [_indicatorBgView removeFromSuperview];
    _indicatorBgView = nil;
    
    dispatch_queue_t queue = dispatch_queue_create("dayhqs", 0);
    dispatch_async(queue, ^{
        
        NSMutableArray *array = [NSMutableArray array];
        [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                YYTimeLineModel *model = [[YYTimeLineModel alloc]initWithDict:obj];
                [array addObject: model];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawWithModels:array];
        });
    });
}

- (void)drawWithModels:(NSArray <id<YYStockTimeLineProtocol>>*) lineModels {
    //更新数据
    [_stockView reDrawWithTimeLineModels:lineModels isShowFiveRecord:NO fiveRecordModel:nil];
    
}


/**
 StockView_Kline代理
 此处Kline和TimeLine都走这一个代理
 @param stockView YYStockView_Kline
 @param model     选中的数据源 若为nil表示取消绘制
 */
- (void)YYStockView:(YYStockView_Kline *)stockView selectedModel:(id<YYLineDataModelProtocol>)model {
    if (model == nil) {
        self.maskView.hidden = YES;
    } else {
        if (!self.maskView) {
            _maskView = [YYStockViewMaskView new];
            _maskView.backgroundColor = [UIColor clearColor];
            [self addSubview:_maskView];
            [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self);
                make.height.equalTo(@20);
            }];
        } else {
            self.maskView.hidden = NO;
        }
        if ([stockView isKindOfClass:[YYStockView_TimeLine class]]) {
            self.maskView.stockType = YYStockTypeTimeLine;
        } else {
            self.maskView.stockType = YYStockTypeLine;
        }
        self.maskView.selectedModel = model;
        [self.maskView setNeedsDisplay];
    }
}


@end
