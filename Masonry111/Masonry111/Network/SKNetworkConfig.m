//
//  SKNetworkConfig.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkConfig.h"

@implementation SKNetworkConfig

+ (SKNetworkConfig *)shareInstance {
    
    static SKNetworkConfig *shareManager = nil;
    static   dispatch_once_t  predicate;
    dispatch_once(&predicate, ^{
        
        shareManager = [[SKNetworkConfig alloc]init];
    });
    return shareManager;
}

- (NSString *)baseUrl {
    
    return @"www.shavekevin.com";
}

@end
