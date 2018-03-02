//
//  SKDemandDetailsVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/2.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseTableViewController.h"
#import "SKDemandModel.h"

typedef NS_ENUM(NSInteger, SKDemandDetailsVCTYPE) {
    SKDemandDetailsVCTYPE_INTREATED, //正在处理
    SKDemandDetailsVCTYPE_TREATED,   //已处理
};

@interface SKDemandDetailsVC : UIViewController

@property (nonatomic, strong) SKDemandModel * model;

@property (nonatomic, assign) SKDemandDetailsVCTYPE vcType;

@end
