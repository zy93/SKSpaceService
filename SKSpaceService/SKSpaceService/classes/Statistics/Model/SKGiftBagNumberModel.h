//
//  SKGiftBagNumberModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKGiftBagNumberModel

@end

@interface SKGiftBagNumberModel : JSONModel
@property (nonatomic,copy) NSString *giftName;
@property (nonatomic,strong) NSNumber *num;
@end

@interface SKGiftBagNumberModel_msg : WOTBaseModel
@property (nonatomic,copy)NSArray <SKGiftBagNumberModel> *msg;
@end

NS_ASSUME_NONNULL_END
