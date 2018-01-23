//
//  WOTEnums.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/6/28.
//  Copyright © 2017年 张雨. All rights reserved.
//

#ifndef WOTEnums_h
#define WOTEnums_h


typedef NS_ENUM(NSInteger, WOTPageMenuVCType) {
    WOTPageMenuVCTypeMetting = 0, //会议室
    WOTPageMenuVCTypeStation,    //工位
    WOTPageMenuVCTypeSite       //场地
};


typedef NS_ENUM(NSInteger, WOT3DBallVCType) {
    WOTEnterprise = 0,
    WOTBookStation,
    WOTReservationsMeeting,
    WOTOthers,

};

typedef NS_ENUM(NSInteger, WOTFeedBackStateType) {
    WOTFeedBackUnRead = 0,
    WOTFeedBackRead,
};


#endif /* WOTEnums_h */
