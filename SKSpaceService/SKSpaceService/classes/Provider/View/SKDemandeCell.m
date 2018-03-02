//
//  SKDemandeCell.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/2.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKDemandeCell.h"

@implementation SKDemandeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView setShadow:[UIColor blackColor]];
    self.btn.layer.cornerRadius = 5.f;
    self.btn.backgroundColor = UICOLOR_MAIN_ORANGE;
    [self.btn setTitleColor:UICOLOR_WHITE forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(demandeCell:buttonClick:)]) {
        [_delegate demandeCell:self buttonClick:self.index];
    }
}

@end
