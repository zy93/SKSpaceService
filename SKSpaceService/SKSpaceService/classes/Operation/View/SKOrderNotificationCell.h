//
//  SKOrderNotificationCell.h
//  SKSpaceService
//
//  Created by wangxiaodong on 10/10/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKOrderNotificationCell : UITableViewCell

@property(nonatomic,strong)UIView *backGroundView;

@property(nonatomic,strong)UILabel *clientNameLabel;
@property(nonatomic,strong)UILabel *clientNameInfoLabel;

@property(nonatomic,strong)UILabel *presetTimeLabel;
@property(nonatomic,strong)UILabel *presetTimeInfoLabel;

@property(nonatomic,strong)UILabel *spaceLabel;
@property(nonatomic,strong)UILabel *spaceInfoLabel;

@property(nonatomic,strong)UILabel *promptInfoLabel;


@end

NS_ASSUME_NONNULL_END
