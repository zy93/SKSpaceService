//
//  SKSelectIdentityView.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/1.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKSelectIdentityView;

@protocol SKSelectIdentityViewDelegate <NSObject>

-(void)selectIdentityView:(SKSelectIdentityView *)view selectIndentity:(NSString *)indentity;

@end

@interface SKSelectIdentityView : UIView

@property (nonatomic, strong) id <SKSelectIdentityViewDelegate> delegate ;

//-(instancetype)initWithButtonTitles:(NSString *)title, ... NS_REQUIRES_NIL_TERMINATION;
-(instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)titles;
-(void)showView;
@end
