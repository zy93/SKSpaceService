//
//  SKLogListCell.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKLogListCell.h"

@implementation SKLogListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.stateLab.layer.cornerRadius = 5.f;
    self.stateLab.clipsToBounds = YES;
    [self.bgView setShadow:UICOLOR_MAIN_BLACK cornerRadius:5.f];
    [self.clientNameLab setTextColor:UICOLOR_GRAY_99];
    [self.clientTelLab  setTextColor:UICOLOR_GRAY_99];
    [self.createTimeLab setTextColor:UICOLOR_GRAY_99];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
