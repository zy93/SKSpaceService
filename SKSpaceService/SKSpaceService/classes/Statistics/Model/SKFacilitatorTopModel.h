//
//  SKFacilitatorTopModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN



@protocol SKFacilitatorTopModel

@end

@interface SKFacilitatorTopModel : JSONModel

@property (nonatomic,strong) NSNumber *num;
@property (nonatomic,copy) NSString *firmName;
@end



@interface SKFacilitatorTopModel_msg: WOTBaseModel
@property (nonatomic,copy) NSArray <SKFacilitatorTopModel>*msg;
@end

NS_ASSUME_NONNULL_END
