//
//  SKAllSpaceBookStationModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKAllSpaceBookStationModel

@end

@interface SKAllSpaceBookStationModel : JSONModel
@property (nonatomic,strong) NSNumber *LongNum;
@property (nonatomic,strong) NSNumber *ShortNum;
@property (nonatomic,strong) NSNumber *subareaNum;
@property (nonatomic,strong) NSNumber *spaceId;
@property (nonatomic,copy) NSString *spaceName;
@end



@interface SKAllSpaceBookStationModel_msg: WOTBaseModel
@property (nonatomic,copy) NSArray <SKAllSpaceBookStationModel>*msg;
@end

NS_ASSUME_NONNULL_END
