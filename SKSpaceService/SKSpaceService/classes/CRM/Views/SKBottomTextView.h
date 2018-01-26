//
//  SKBottomTextView.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKBottomTextView : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) void(^editingText)(NSString *string);

@end
