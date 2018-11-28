//
//  SKStatisticsOneFacilitatorModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN


@protocol SKStatisticsOneFacilitatorModel

@end

@interface SKStatisticsOneFacilitatorModel : JSONModel

@property (nonatomic,strong) NSNumber *num;
@property (nonatomic,copy) NSString *date;
@end



@interface SKStatisticsOneFacilitatorModel_msg: WOTBaseModel
@property (nonatomic,copy) NSArray <SKStatisticsOneFacilitatorModel>*msg;
@end

NS_ASSUME_NONNULL_END
