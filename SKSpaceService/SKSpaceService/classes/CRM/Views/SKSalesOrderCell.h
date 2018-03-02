//
//  SKSalesOrderCell.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKSalesOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;

@property (weak, nonatomic) IBOutlet UIView *starBGView;
@property (weak, nonatomic) IBOutlet UIButton *star1IV;
@property (weak, nonatomic) IBOutlet UIButton *star2IV;
@property (weak, nonatomic) IBOutlet UIButton *star3IV;
@property (weak, nonatomic) IBOutlet UIButton *star4IV;

@end
