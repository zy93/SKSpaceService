//
//  SKSelectTypeVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseTableViewController.h"

@interface SKSelectTypeVC : WOTBaseTableViewController
@property (nonatomic, copy) void(^selectSpaceBlock)(id model);
@property (nonatomic, strong) NSArray *tableList;
@end