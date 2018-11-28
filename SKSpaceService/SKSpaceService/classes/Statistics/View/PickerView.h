//
//  PickerView.h
//  Test
//
//  Created by K.O on 2018/7/20.
//  Copyright © 2018年 rela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"




@protocol PickerViewResultDelegate <NSObject>
@optional
- (void)pickerView:(NSInteger)row result:(NSString *)string;
@end



@interface PickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *picker;
@property (nonatomic,strong)UIDatePicker *datePicke;
@property(nonatomic,strong)NSMutableArray *array;

//默认选中第一列
@property (nonatomic,assign)NSInteger selectComponent;


@property(nonatomic,weak)id<PickerViewResultDelegate>delegate;

- (void)setSpaceData:(NSMutableArray *)spaceData withTitle:(NSString *)title;
- (void)hideAnimation;
@end
