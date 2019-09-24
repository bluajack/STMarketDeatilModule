//
//  YYLineDataModel.h
//  投融宝
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "YYStockDataProtocol.h"

/**
 外部实现
 */
@interface YYLineDataModel : NSObject <YYLineDataModelProtocol>

- (void)updateMA:(NSUInteger )index;

@property (nonatomic, strong) NSArray *parentDictArray;


//@property (nonatomic, assign) BOOL isShowDay;
// 这个sb作者 代理居然写strong，对象释放不了，害老子查找错误半天
@property (nonatomic, weak) id<YYLineDataModelProtocol> preDataModel;
@property (nonatomic, strong) NSString *showDay;
@end
