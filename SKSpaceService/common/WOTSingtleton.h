//
//  WOTSingtleton.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ORDER_TYPE) {
    ORDER_TYPE_ACCEPTABLEORDER,
    ORDER_TYPE_ACCEPTEDORDER,
    ORDER_TYPE_SERVICINGORDER,
    ORDER_TYPE_FINISHEDORDER,
};

@interface WOTSingtleton : NSObject

@property(nonatomic,assign)ORDER_TYPE orderType;
+(instancetype)shared;
@end
