//
//  SKTextField.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTextField : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *arrowIV;
@property (nonatomic, assign, getter=isButton) BOOL button; //类型YES：输入框，NO：button

@property (nonatomic, strong) void (^selectText)(UITextField *textField);

@end
