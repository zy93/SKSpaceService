//
//  SKActivityApplyModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN


@protocol SKActivityApplyModel

@end

@interface SKActivityApplyModel : JSONModel

@property (nonatomic,strong) NSNumber *num;
@property (nonatomic,copy) NSString *title;
@end



@interface SKActivityApplyModel_msg: WOTBaseModel
@property (nonatomic,copy) NSArray <SKActivityApplyModel>*msg;
@end

NS_ASSUME_NONNULL_END
