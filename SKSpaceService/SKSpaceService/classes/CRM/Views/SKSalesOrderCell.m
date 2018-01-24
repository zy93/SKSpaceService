//
//  SKSalesOrderCell.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSalesOrderCell.h"

@implementation SKSalesOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView setShadow:UICOLOR_MAIN_BLACK];
    
    
    self.stateLab.layer.cornerRadius = 3.f;
    self.stateLab.clipsToBounds = YES;
    self.stateLab.backgroundColor = UICOLOR_BLUE_7d;
    
    self.titleLab.textColor = [UIColor whiteColor];
    
    self.dateLab.textColor = UICOLOR_GRAY_99;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end