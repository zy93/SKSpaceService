//
//  SKDemandeCell.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/2.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKDemandeCell;

@protocol SKDemandeCellDelegate <NSObject>
-(void)demandeCell:(SKDemandeCell *)cell buttonClick:(NSIndexPath *)index;
@end

@interface SKDemandeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UILabel *addrValueLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *nameValueLab;
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *telValueLab;


@property (weak, nonatomic) IBOutlet UILabel *demandeLab;

@property (weak, nonatomic) IBOutlet UILabel *demandeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *createLab;
@property (weak, nonatomic) IBOutlet UILabel *createValueLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewBottomConstraints;

@property (nonatomic, strong) id <SKDemandeCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
@property (weak, nonatomic) IBOutlet UILabel *facilitatorInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *facilitatorLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facilitatorTopConstraint;

@end
