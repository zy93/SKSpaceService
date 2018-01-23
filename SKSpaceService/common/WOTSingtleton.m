//
//  WOTSingtleton.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WOTSingtleton.h"

@implementation WOTSingtleton


+(instancetype)shared{
    static WOTSingtleton *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc]init];
    });
    return  instance;
}



@end
