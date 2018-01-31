//
//  WOTUserSingleton.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKLoginModel.h"

@interface WOTUserSingleton : NSObject

//用户信息
@property (nonatomic, strong) SKLoginModel *userInfo;
@property (nonatomic, assign, getter=isLogin) BOOL login;
@property (nonatomic, strong) NSString *currentStatus; //当前身份状态 维修清洁、销售人员

+(instancetype)shared;
-(void)saveUserInfoToPlistWithModel:(SKLoginModel *)model;
-(void)userLogout;

@end
