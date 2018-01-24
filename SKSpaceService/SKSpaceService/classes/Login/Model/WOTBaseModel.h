//
//  WOTBaseModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/23.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//所有的model都要集成该basemodel
@interface WOTBaseModel : JSONModel
@property (nonatomic, strong) NSString*code;
@property (nonatomic, strong) NSString*result;
@end
