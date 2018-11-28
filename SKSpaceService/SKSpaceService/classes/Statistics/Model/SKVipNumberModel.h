//
//  SKVipNumberModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 20/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WOTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKVipNumberModel : JSONModel
@property (nonatomic,strong) NSNumber *user;
@property (nonatomic,strong) NSNumber *VIPuser;
@end



@interface SKVipNumberModel_msg : WOTBaseModel
@property (nonatomic,strong) SKVipNumberModel *msg;
@end

NS_ASSUME_NONNULL_END
