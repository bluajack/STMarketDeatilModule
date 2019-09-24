//
//  NewOptionMarketView.m
//  TSMarketDeatilModule
//
//  Created byDWFutures on 2018/12/11.
//  Copyright © 2018年DWFutures. All rights reserved.
//

#import "NewOptionMarketView.h"

#import "LBPageToolBar.h"
#import "BKTimeLineView.h"
#import "BKBaseKLineView.h"
#import "ColorMacro.h"
#import "Masonry.h"

@interface NewOptionMarketView()<LBPageToolBarDelegate>

@property (nonatomic, strong) BKTimeLineView *timeLineView;
@property (nonatomic, strong) BKBaseKLineView *oneKlineView;
@property (nonatomic, strong) BKBaseKLineView *threeKlineView;
@property (nonatomic, strong) BKBaseKLineView *fiveKlineView;
@property (nonatomic, strong) BKBaseKLineView *fifteenKlineView;
@property (nonatomic, strong) BKBaseKLineView *sixtyKlineView;
@property (nonatomic, strong) BKBaseKLineView *dayKlineView;

@property (nonatomic, copy) RefreshBlock refreshBlock;

@end

@implementation NewOptionMarketView

- (instancetype)initWithFrame:(CGRect)frame RefreshBlock:(RefreshBlock)refreshBlock {
    NewOptionMarketView *view = [[NewOptionMarketView alloc] initWithFrame:frame];
    view.refreshBlock = refreshBlock;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup {
    //中间四个选择图形界面展示
    LBPageToolBar *pageToolBar = [[LBPageToolBar alloc] initWithTitles:@[@"分时",@"1分",@"3分",@"5分",@"15分",@"60分",@"日K"]];
    // pageToolBar.selectedIndex = 1;
    pageToolBar.delegate = self;
    pageToolBar.backgroundColor = BackColor;
    [self addSubview:pageToolBar];
    [pageToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    _dayKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_dayKlineView];
    [_dayKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _sixtyKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_sixtyKlineView];
    [_sixtyKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _fifteenKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_fifteenKlineView];
    [_fifteenKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _fiveKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_fiveKlineView];
    [_fiveKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _threeKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_threeKlineView];
    [_threeKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _oneKlineView = [[BKBaseKLineView alloc] init];
    [self addSubview:_oneKlineView];
    [_oneKlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    _timeLineView = [[BKTimeLineView alloc] init];
    [self addSubview:_timeLineView];
    [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(pageToolBar.mas_bottom).offset(10);
    }];
    
    pageToolBar.backgroundColor = UIColorFromRGB(0x181E2B);
    _timeLineView.backgroundColor = UIColorFromRGB(0x181E2B);
    _timeLineView.dottedLineColor = UIColorFromRGB(0x181E2B);
    
    _dayKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    _sixtyKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    _fifteenKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    _fiveKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    _threeKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    _oneKlineView.stockBackGroundColor = UIColorFromRGB(0x181E2B);
    
    !_refreshBlock ?: _refreshBlock(RefreshTimeType);
}

-(void)itemButtonClickAtIndex:(NSInteger)index {
    if (index == 0) {
        [self bringSubviewToFront:_timeLineView];
    }else if (index == 1) {
        [self bringSubviewToFront:_oneKlineView];
        if (_oneKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshOneKline);
        }
    }else if (index == 2) {
        [self bringSubviewToFront:_threeKlineView];
        if (_threeKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshThreeKline);
        }
    }else if (index == 3) {
        [self bringSubviewToFront:_fiveKlineView];
        if (_fiveKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshFiveKline);
        }
    }else if (index == 4) {
        [self bringSubviewToFront:_fifteenKlineView];
        if (_fifteenKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshFifteenKline);
        }
    }else if (index == 5) {
        [self bringSubviewToFront:_sixtyKlineView];
        if (_sixtyKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshSixtyKline);
        }
    }else if (index == 6) {
        [self bringSubviewToFront:_dayKlineView];
        if (_dayKlineView.indicatorBgView) {
            !_refreshBlock ?: _refreshBlock(RefreshDayKline);
        }
    }
}

- (void)dealTimeDataWithHigh:(NSString *)highStr Low:(NSString *)lowStr Times:(NSArray *)times Swing:(NSString *)swing ClosePrice:(NSString *)closePrice Accuracy:(NSString *)accuracy TimeOffset:(NSMutableArray *)timeOffset xAxisMaxValue:(NSInteger)xAxisMaxValue {
    [_timeLineView dealTimeDataWithHigh:highStr Low:lowStr Times:times Swing:swing ClosePrice:closePrice Accuracy:accuracy TimeOffset:timeOffset xAxisMaxValue:xAxisMaxValue];
}

- (void)kLineModelWithDictionary:(NSArray<NSDictionary*> *)response RefreshViewType:(RefreshViewType)type {
    switch (type) {
        case RefreshOneKline:
            [_oneKlineView kLineModelWithDictionary:response];
            break;
        case RefreshThreeKline:
            [_threeKlineView kLineModelWithDictionary:response];
            break;
        case RefreshFiveKline:
            [_fiveKlineView kLineModelWithDictionary:response];
            break;
        case RefreshFifteenKline:
            [_fifteenKlineView kLineModelWithDictionary:response];
            break;
        case RefreshSixtyKline:
            [_sixtyKlineView kLineModelWithDictionary:response];
            break;
        case RefreshDayKline:
            [_dayKlineView kLineModelWithDictionary:response];
            break;
            
        default:
            break;
    }
}


@end
