//
//  SKLogContentCell.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKLogContentCell.h"

@implementation SKLogContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
    self.timeLab.textColor = UICOLOR_GRAY_99;
    self.roundView.layer.cornerRadius = 4.f;
    self.roundView.backgroundColor  = UIColorFromRGB(0xb2b2b2);
    self.topLine.backgroundColor    = UIColorFromRGB(0xe0e0e0);
    self.bottomLine.backgroundColor = UIColorFromRGB(0xe0e0e0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
