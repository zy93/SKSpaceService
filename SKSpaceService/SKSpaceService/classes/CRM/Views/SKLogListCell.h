//
//  SKLogListCell.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKLogListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *clientNameLab;
@property (weak, nonatomic) IBOutlet UILabel *clientTelLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *star1Btn;
@property (weak, nonatomic) IBOutlet UIButton *star2Btn;
@property (weak, nonatomic) IBOutlet UIButton *star3Btn;
@property (weak, nonatomic) IBOutlet UIButton *star4Btn;

@end
