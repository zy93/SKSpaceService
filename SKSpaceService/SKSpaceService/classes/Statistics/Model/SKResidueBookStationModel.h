//
//  SKResidueBookStationModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKResidueBookStationModel : JSONModel
@property (nonatomic,strong) NSNumber *N;
@property (nonatomic,strong) NSNumber *R;
@property (nonatomic,strong) NSNumber *rate;
@end

@interface SKResidueBookStationModel_list : JSONModel
@property (nonatomic,strong) SKResidueBookStationModel*jsonLong;
@property (nonatomic,strong) SKResidueBookStationModel*jsonShort;
@property (nonatomic,strong) SKResidueBookStationModel*jsonSubarea;
@end

@interface SKResidueBookStationModel_msg : WOTBaseModel
@property (nonatomic,strong) SKResidueBookStationModel_list *msg;
@end

NS_ASSUME_NONNULL_END
