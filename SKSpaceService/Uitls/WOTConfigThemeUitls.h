//
//  WOTConfigThemeUitls.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/6/28.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WOTConfigThemeUitls : NSObject
+(instancetype)shared;

-(void)setLabelTexts:(NSArray *)labels withTexts:(NSArray *)texts;
-(void)setLabelColorss:(NSArray *)labels withColor:(UIColor *)color;
-(void)loadtagsBtn:(NSArray *)tagsArray superView:(UIView *)tagsView;

-(void)showLoginVC:(UIViewController *)persentVC;

-(void)touchViewHiddenKeyboard:(UIView *)view;

-(void)showRemindingAlert:(UIViewController *)vc message:(NSString *)message okBlock:(void(^)())okBlock cancel:(void(^)())cancelBlock;
- (NSString *)getIPAddress;
@property(nonatomic,copy)void (^hiddenKeyboardBlcok)();

@end
