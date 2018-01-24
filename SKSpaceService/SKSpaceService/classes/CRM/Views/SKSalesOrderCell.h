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
@property (weak, nonatomic) IBOutlet UIView *starBGView;
@property (weak, nonatomic) IBOutlet UIImageView *star1IV;
@property (weak, nonatomic) IBOutlet UIImageView *star2IV;
@property (weak, nonatomic) IBOutlet UIImageView *star3IV;
@property (weak, nonatomic) IBOutlet UIImageView *star4IV;

@end
