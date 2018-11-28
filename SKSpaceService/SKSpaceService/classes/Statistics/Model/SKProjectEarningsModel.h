//
//  15
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKProjectEarningsModel : JSONModel
@property (nonatomic,strong) NSNumber *giftMoney;
@property (nonatomic,strong) NSNumber *longMoney;
@property (nonatomic,strong) NSNumber *billMoney;
@end

@interface SKProjectEarningsModel_msg : WOTBaseModel
@property (nonatomic,strong) SKProjectEarningsModel *msg;
@end

NS_ASSUME_NONNULL_END
