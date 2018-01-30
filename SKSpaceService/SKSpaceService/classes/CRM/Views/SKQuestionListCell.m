//
//  SKQuestionListCell.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKQuestionListCell.h"

@implementation SKQuestionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLab setFont:[UIFont boldSystemFontOfSize:17]];
    [self.subtitleLab setFont:[UIFont systemFontOfSize:15]];
    [self.subtitleLab setTextColor:UICOLOR_GRAY_66];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
