//
//  KLineAndMinuteController.h
//  eightThousandPoints
//
//  Created by bluajack on 2017/8/6.
//  Copyright © 2017年 bluajack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLineAndMinuteController : UIViewController

@property (nonatomic, weak) UITableView *tableView;

/**
 是否显示五档图
 */
@property (assign, nonatomic) BOOL isShowFiveRecord;

- (void)kLineModelWithDictionary:(NSArray<NSDictionary*> *)response;

- (void)minuteModelWithDictionary:(NSArray<NSDictionary*> *)response;

- (void)fiveModelWithDictionary:(NSDictionary *)response;

@end
