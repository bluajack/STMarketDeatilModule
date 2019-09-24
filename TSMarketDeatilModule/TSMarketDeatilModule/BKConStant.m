//
//  BKConStant.m
//  TSMarketDeatilModule
//
//  Created byDWFutures on 2019/1/8.
//  Copyright © 2019年DWFutures. All rights reserved.
//

#import "BKConStant.h"

@implementation BKConStant

+ (instancetype)sharedInstance {
    static BKConStant *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (NSString *)accuracy {
    if (_accuracy == nil) {
        return @"%.2f";
    }
    return _accuracy;
}

@end
