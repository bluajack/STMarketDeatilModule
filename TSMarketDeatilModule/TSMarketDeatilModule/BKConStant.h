//
//  BKConStant.h
//  TSMarketDeatilModule
//
//  Created byDWFutures on 2019/1/8.
//  Copyright © 2019年DWFutures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKConStant : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *accuracy;

@end
