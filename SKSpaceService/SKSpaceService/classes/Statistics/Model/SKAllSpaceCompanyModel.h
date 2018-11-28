//
//  SKAllSpaceCompanyModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKAllSpaceCompanyModel

@end

@interface SKAllSpaceCompanyModel : JSONModel
@property (nonatomic,strong) NSNumber *companyNum;
@property (nonatomic,strong) NSNumber *spaceId;
@property (nonatomic,copy) NSString *spaceName;
@end



@interface SKAllSpaceCompanyModel_msg: WOTBaseModel
@property (nonatomic,copy) NSArray <SKAllSpaceCompanyModel>*msg;
@end

NS_ASSUME_NONNULL_END
