//
//  KLineAndMinuteController.m
//  eightThousandPoints
//
//  Created by bluajack on 2017/8/6.
//  Copyright © 2017年 bluajack. All rights reserved.
//

#import "KLineAndMinuteController.h"
#import "UIColor+YYStockTheme.h"
#import <Masonry/Masonry.h>
#import "YYFiveRecordModel.h"
#import "YYLineDataModel.h"
#import "YYTimeLineModel.h"
#import "YYStockVariable.h"
#import "YYStock.h"

@interface KLineAndMinuteController ()<YYStockDataSource>
/**
 K线数据源
 */
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;
@property (copy, nonatomic) NSArray *stockDataKeyArray;
@property (copy, nonatomic) NSArray *stockTopBarTitleArray;
@property (strong, nonatomic) YYFiveRecordModel *fiveRecordModel;

@property (strong, nonatomic) YYStock *stock;

@end

@implementation KLineAndMinuteController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStockView];
}

- (void)initStockView {
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.view.frame dataSource:self tableView:self.tableView];
    _stock = stock;
    stock.tableView = self.tableView;
    [self.view addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


//处理五档图转model
- (void)fiveModelWithDictionary:(NSDictionary *)response{
    dispatch_queue_t queue = dispatch_queue_create("minutes", 0);
    dispatch_async(queue, ^{
        if (self.isShowFiveRecord) {
            self.fiveRecordModel = [[YYFiveRecordModel alloc]initWithDict:response];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.stock draw];
        });
    });
}


// 处理kline转model
- (void)kLineModelWithDictionary:(NSArray<NSDictionary*> *)response{
    
    dispatch_queue_t queue = dispatch_queue_create("dayhqs", 0);
    dispatch_async(queue, ^{
        
        NSMutableArray *array = [NSMutableArray array];
        __block YYLineDataModel *preModel;
        //NSLog(@"---???????");
        int i = 0;
        for (id obj in response) {
            @autoreleasepool {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                model.parentDictArray = response;
                [model updateMA:i];
                
                if ([response count] % 18 == (i + 1 )%18 ) {
                    model.showDay = obj[@"day"];
                }
                
                [array addObject: model];
                preModel = model;
                i++;
            }
        }
        //NSLog(@"----%lu",(unsigned long)array.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.stockDatadict setObject:array forKey:@"dayhqs"];
            [self.stock draw];
        });
    });
    
    
}

// 处理分时转model
- (void)minuteModelWithDictionary:(NSArray<NSDictionary*> *)response{
    
    [self.stockDatadict removeObjectForKey:@"minutes"];
    //NSLog(@"---???");
    NSMutableArray *array = [NSMutableArray array];
    [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            YYTimeLineModel *model = [[YYTimeLineModel alloc]initWithDict:obj];
            [array addObject: model];
        }
    }];
    //NSLog(@"----???");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.stockDatadict setObject:array forKey:@"minutes"];
        [self.stock singleDrawMinute];
    });
}

/*******************************************股票数据源代理*********************************************/
-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock {
    return self.stockTopBarTitleArray;
}

-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index {
    return index < self.stockDataKeyArray.count ? self.stockDatadict[self.stockDataKeyArray[index]] : nil;
}

-(YYStockType)stockTypeOfIndex:(NSInteger)index {
    return index == 0 ? YYStockTypeTimeLine : YYStockTypeLine;
}

- (id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index {
    return self.fiveRecordModel;
}

- (BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index {
    return self.isShowFiveRecord;
}

/*******************************************getter*********************************************/
- (NSMutableDictionary *)stockDatadict {
    if (!_stockDatadict) {
        _stockDatadict = [NSMutableDictionary dictionary];
    }
    return _stockDatadict;
}

- (NSArray *)stockDataKeyArray {
    if (!_stockDataKeyArray) {
        _stockDataKeyArray = @[@"minutes",@"dayhqs"];
    }
    return _stockDataKeyArray;
}

- (NSArray *)stockTopBarTitleArray {
    if (!_stockTopBarTitleArray) {
        _stockTopBarTitleArray = @[@"分时",@"日K"];
        //        _stockTopBarTitleArray = @[@"分时",@"日K",@"周K",@"月K"];
    }
    return _stockTopBarTitleArray;
}

- (NSString *)getToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)dealloc {
    //NSLog(@"DEALLOC");
}

@end
