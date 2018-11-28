//
//  XAxisValueFormatter.m
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "XAxisValueFormatter.h"

@implementation XAxisValueFormatter

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    NSString *xAxisStr;
    if (!(value == -1)) {
        xAxisStr = self.xAxisDatas[(int)value];
    }else
    {
        xAxisStr = @"";
    }
    return xAxisStr;
//    return @"df";
}

@end
