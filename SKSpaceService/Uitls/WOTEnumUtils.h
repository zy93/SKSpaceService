//
//  WOTEnumUtils.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOTEnums.h"

@interface WOTEnumUtils : NSObject
-(WOT3DBallVCType)Wot3DballVCtypeenumToString:(NSString *)ballTitle;
-(NSString *)WOTFeedBackStateToString:(NSInteger)state;

@end
