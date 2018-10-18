//
//  SKOperationmanageViewController.h
//  SKSpaceService
//
//  Created by wangxiaodong on 10/10/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WOTPageMenuVCType) {
    WOTPageMenuVCTypeStation, //工位
    WOTPageMenuVCTypeMeeting, //会议室
    WOTPageMenuVCTypeLongTimeStation,//长租工位
};

@interface SKOperationmanageViewController : UIViewController
@property(nonatomic,assign)WOTPageMenuVCType orderlisttype;
@end

NS_ASSUME_NONNULL_END
