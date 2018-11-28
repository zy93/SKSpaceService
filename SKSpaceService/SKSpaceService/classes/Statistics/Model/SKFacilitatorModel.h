//
//  SKFacilitatorModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 23/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN



@protocol SKFacilitatorModel
@end

@interface SKFacilitatorModel : JSONModel
@property (nonatomic, strong) NSNumber *facilitatorId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *businessScope;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *contacts;
@property (nonatomic, copy) NSString *facilitatorState;
@property (nonatomic, copy) NSString *facilitatorType;
@property (nonatomic, copy) NSString *firmLogo;
@property (nonatomic, copy) NSString *firmName;
@property (nonatomic, copy) NSString *firmShow;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *site;
@property (nonatomic, copy) NSString *spaceList;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *website;
@end


@interface SKFacilitatorModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKFacilitatorModel> *list;
@end


@interface SKFacilitatorModel_msg : WOTBaseModel
@property(nonatomic,strong)SKFacilitatorModel_list *msg;
@end


NS_ASSUME_NONNULL_END
