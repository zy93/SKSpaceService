//
//  SKOrderNumberModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 20/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKOrderNumberModel

@end

@interface SKOrderNumberModel : JSONModel
@property (nonatomic,copy) NSString *CommodityKind;
@property (nonatomic,strong) NSNumber *num;
@end

@interface SKOrderNumberModel_msg : WOTBaseModel
@property (nonatomic,copy)NSArray <SKOrderNumberModel> *msg;
@end

NS_ASSUME_NONNULL_END
