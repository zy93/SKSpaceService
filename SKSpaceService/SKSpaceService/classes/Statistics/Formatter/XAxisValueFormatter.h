//
//  XAxisValueFormatter.h
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSpaceService-Bridge-Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface XAxisValueFormatter : NSObject<IChartAxisValueFormatter>

@property (nonatomic, copy) NSArray *xAxisDatas;

@end

NS_ASSUME_NONNULL_END
