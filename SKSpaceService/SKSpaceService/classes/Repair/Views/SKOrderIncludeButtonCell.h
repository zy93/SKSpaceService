//
//  SKOrderIncludeButtonCell.h
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKOrderIncludeButtonCell : UITableViewCell

@property(nonatomic,strong)UIView *backGroundView;

@property(nonatomic,strong)UILabel *serviceAddressLabel;
@property(nonatomic,strong)UILabel *serviceAddressInfoLabel;

@property(nonatomic,strong)UILabel *serviceArticleLabel;
@property(nonatomic,strong)UILabel *serviceArticleInfoLabel;

@property(nonatomic,strong)UILabel *serviceCauseLabel;
@property(nonatomic,strong)UILabel *serviceCauseInfoLabel;

@property(nonatomic,strong)UILabel *serviceTimeLabel;
@property(nonatomic,strong)UILabel *serviceTimeInfoLabel;

@property(nonatomic,strong)UIButton *disposeButton;

@end
