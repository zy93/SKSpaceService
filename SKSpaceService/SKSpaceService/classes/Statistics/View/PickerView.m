//
//  PickerView.m
//  Test
//
//  Created by K.O on 2018/7/20.
//  Copyright © 2018年 rela. All rights reserved.
//

#import "PickerView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGB1(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define WScale ([UIScreen mainScreen].bounds.size.width) / 375

#define HScale ([UIScreen mainScreen].bounds.size.height) / 667


#define KFont [UIFont systemFontOfSize:15]


@interface PickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *completeBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,assign) NSInteger selectIndex;
@end



@implementation PickerView

- (UIPickerView *)picker{
    
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIDatePicker *)datePicke{
    
    if (!_datePicke) {
        
        _datePicke = [UIDatePicker new];
    }
    
    return _datePicke;
}

- (NSMutableArray *)array{
    if (!_array) {
        
        _array = [NSMutableArray array];
        
    }
    
    return _array;
}
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self initUI];
        
    }
    
    return self;
}


- (void)initUI{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.frame = [UIScreen mainScreen].bounds;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-10, KScreenWidth, 280*HScale)];
    [self addSubview:_bgView];
    _bgView.tag = 100;
     _bgView.backgroundColor = [UIColor whiteColor];
     [self showAnimation];
    
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cancelBtn.titleLabel.font = KFont;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:RGB1(30, 144, 255, 1) forState:UIControlStateNormal];
    //完成
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.completeBtn.titleLabel.font = KFont;
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completeBtn setTitleColor:RGB1(30, 144, 255, 1) forState:UIControlStateNormal];
    
    WS(ws);
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = RGB1(51, 51, 51, 1);
    self.titleLab.font = KFont;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.completeBtn.mas_centerY);
    }];


    self.line = [[UIView alloc]init];
    [self.bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(0.5);
        
    }];
    self.line.backgroundColor = RGB1(224, 224, 224, 1);
    
}

#pragma mark type
- (void)setSpaceData:(NSMutableArray *)spaceData withTitle:(NSString *)title{
    self.titleLab.text = title;
    [self.array addObject:spaceData];
    [self isDataPicker:NO];
    [self.picker selectRow:70 inComponent:0 animated:NO];
}

- (void)setSelectComponent:(NSInteger)selectComponent{
    _selectComponent = selectComponent;
     [self.picker selectRow:selectComponent inComponent:0 animated:NO];
   
}

- (void)isDataPicker:(BOOL)isData{
    
    WS(ws);
    
    if (isData) {
        
        [_bgView addSubview:self.datePicke];
        
        [self.datePicke mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
       
        
    }else{
        
        [_bgView addSubview:self.picker];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
}

#pragma mark Click
- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

-(void)completeBtnClick{
    
    [self hideAnimation];
     NSString *resultStr = [NSString string];
    NSInteger row = 0;
    for (int i = 0; i < self.array.count; i++) {
        
        NSArray *arr = [self.array objectAtIndex:i];
        row =[self.picker selectedRowInComponent:i];
        NSString *str = [arr objectAtIndex:row];
        resultStr = [resultStr stringByAppendingString:str];
    }


    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:result:)]) {
        [_delegate pickerView:row result:resultStr];
    }
}


#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch.view.tag !=100) {
        [self hideAnimation];
    }
}

- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height-260*HScale;
        self.bgView.frame = frame;
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height;
        self.bgView.frame = frame;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    return 1;
//    if (self.type == PickerViewTypeRange || self.type==PickerViewTypeCity) {
//
//        return 2;
//    }
//
//    return self.array.count;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    return arr.count;
}


//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 110;
}

//防止崩溃
- (NSUInteger)indexOfNSArray:(NSArray *)arr WithStr:(NSString *)str{
    
    NSUInteger chosenDxInt = 0;
    if (str && ![str isEqualToString:@""]) {
        chosenDxInt = [arr indexOfObject:str];
        if (chosenDxInt == NSNotFound)
            chosenDxInt = 0;
    }
    return chosenDxInt;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    return 40.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
    for (int i = 0; i < self.array.count; ++i) {
        if (i == component) {
            myView.text = self.array[i][row];
            
        }
        
    }
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont systemFontOfSize:13];
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}


@end
