//
//  SKProviderOrderListVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/2/28.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseTableViewController.h"

typedef NS_ENUM(NSInteger, SKProviderOrderListVCTYPE) {
    SKProviderOrderListVCTYPE_UNTREATED, //未处理
    SKProviderOrderListVCTYPE_INTREATED, //正在处理
    SKProviderOrderListVCTYPE_TREATED,   //已处理
};

@interface SKProviderOrderListVC : WOTBaseTableViewController
@property (nonatomic, assign) SKProviderOrderListVCTYPE vcType;
@end
