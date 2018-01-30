//
//  SKQuestionDetailsHeader.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKQuestionDetailsHeader : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *clientNameLab;
@property (nonatomic, strong) UILabel *intentionLab;
@property (nonatomic, strong) UILabel *intentionSpaceLab;

@property (nonatomic, strong) UIButton *star1Btn;
@property (nonatomic, strong) UIButton *star2Btn;
@property (nonatomic, strong) UIButton *star3Btn;
@property (nonatomic, strong) UIButton *star4Btn;

@end
