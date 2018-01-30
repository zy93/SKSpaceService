//
//  WOTWorkspaceListVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSpaceModel.h"
#import "SKSalesOrderModel.h"
#import "WOTBaseTableViewController.h"

@interface WOTSelectWorkspaceListVC : WOTBaseTableViewController
@property (nonatomic, copy) void(^selectSpaceBlock)(WOTSpaceModel *model);
@property (nonatomic, assign) BOOL isChangeSpace;
@property (nonatomic, strong) SKSalesOrderModel * model;;

@end
