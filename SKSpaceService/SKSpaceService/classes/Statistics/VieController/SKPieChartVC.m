//
//  SKPieChartVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 20/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKPieChartVC.h"
#import "SKSpaceService-Bridge-Header.h"
#import "WOTDatePickerView.h"
#import "JudgmentTime.h"
#import "SKVipNumberModel.h"
#import "SKOrderNumberModel.h"
#import "SKGiftBagNumberModel.h"
#import "SKResidueBookStationModel.h"
#import "SKProjectEarningsModel.h"

typedef NS_ENUM(NSInteger,ClickButtonType)
{
    ClickButtonTypeStart,
    ClickButtonTypeEnd
} ;

@interface SKPieChartVC ()<ChartViewDelegate>

@property (nonatomic,strong) PieChartView *pieView;
@property (nonatomic,strong) NSMutableArray *parties;
@property (nonatomic,strong) NSMutableArray *partiesValueS;
@property (nonatomic,strong) UILabel *startTimeLabel;
@property (nonatomic,strong) UIButton *startTimeButton;
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UIButton *endTimeButton;
@property (nonatomic,strong) UIButton *queryButton;

@property (nonatomic,strong) UIImageView *infoImageView;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic, strong)WOTDatePickerView *datepickerview;
@property (nonatomic,assign) ClickButtonType clickButtonType;
@property (nonatomic,copy) NSString *startTimeStr;
@property (nonatomic,copy) NSString *endTimeStr;
@property (nonatomic,strong) JudgmentTime *judgmentTime;
@property (nonatomic,copy) NSString *currentstartTimeStr;
@property (nonatomic,copy) NSString *currentendTimeStr;
@end

@implementation SKPieChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    [self getStartTimeAndEndTime];
    self.parties = [[NSMutableArray alloc] init];
    [self.parties addObject:@"没有数据"];
    self.partiesValueS =[[NSMutableArray alloc] init];
    [self.partiesValueS addObject:@100];
    [self.view addSubview:self.pieView];
    [self.view addSubview:self.startTimeLabel];
    [self.view addSubview:self.startTimeButton];
    [self.view addSubview:self.endTimeLabel];
    [self.view addSubview:self.endTimeButton];
    [self.view addSubview:self.queryButton];
    [self.view addSubview:self.infoImageView];
    [self.view addSubview:self.infoLabel];
    [self creatDataPickerView];
    [self layoutSubviews];
    
    [self isShowButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self confirmTimeWithInterface];
}

-(void)layoutSubviews
{
    [self.pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SCREEN_WIDTH);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startTimeButton.mas_centerY);
        make.right.equalTo(self.startTimeButton.mas_left).with.offset(-5);
        make.width.mas_offset(60);
    }];
    
    [self.startTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pieView.mas_top).with.offset(-50);
        make.right.equalTo(self.view.mas_centerX).with.offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(25);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.endTimeButton.mas_centerY);
        make.left.equalTo(self.view.mas_centerX).with.offset(10);
        make.width.mas_offset(60);
    }];
    
    [self.endTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeButton.mas_top);
        make.left.equalTo(self.endTimeLabel.mas_right).with.offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(25);
    }];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTimeButton.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.view);
        make.width.mas_offset(100);
    }];
    
    [self.infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_offset(70);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoImageView.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - 按钮显示问题
-(void)isShowButton
{
    if ([self.titleStr isEqualToString:@"会员人数统计"]||[self.titleStr isEqualToString:@"剩余工位统计"]) {
        self.startTimeLabel.hidden = YES;
        self.startTimeButton.hidden = YES;
        self.endTimeLabel.hidden = YES;
        self.endTimeButton.hidden = YES;
        self.queryButton.hidden = YES;
    }else
    {
        self.startTimeLabel.hidden = NO;
        self.startTimeButton.hidden = NO;
        self.endTimeLabel.hidden = NO;
        self.endTimeButton.hidden = NO;
        self.queryButton.hidden = NO;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.datepickerview.hidden = YES;
}

- (void)setDataCount:(NSInteger)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.partiesValueS[i] intValue] label:self.parties[i % self.parties.count] icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];

    dataSet.drawIconsEnabled = NO;

    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);

    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    dataSet.colors = colors;

    dataSet.xValuePosition = PieChartValuePositionOutsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.3;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    if ([self.parties[0] isEqualToString:@"没有数据"]) {
        dataSet.valueLineColor = [UIColor clearColor];
    }else
    {
        dataSet.valueLineColor = [UIColor brownColor];
    }

    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];

    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 2;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    //[data setValueTextColor:UIColor.whiteColor];
    if ([self.parties[0] isEqualToString:@"没有数据"]) {
         [data setValueTextColor:[UIColor clearColor]];
    }else
    {
         [data setValueTextColor:[UIColor brownColor]];
    }

    _pieView.data = data;
    if (range > 0) {
        [self setMiddleTitle:range];
    }
    [_pieView highlightValues:nil];
   
}

#pragma mark - 设置扇形中间标签
-(void)setMiddleTitle:(int)rang
{
    if (rang == 0) {
        [MBProgressHUDUtil showMessage:@"" toView:self.view];
        return;
    }
    if ([self.titleStr isEqualToString:@"会员人数统计"] ) {
      self.pieView.centerText = [NSString stringWithFormat:@"共%d人",rang];
    }
    
    if ([self.titleStr isEqualToString:@"订单数量统计"]) {
        self.pieView.centerText = [NSString stringWithFormat:@"共%d单",rang];
    }
    
    if ([self.titleStr isEqualToString:@"礼包数量统计"]|| [self.titleStr isEqualToString:@"剩余工位统计"]) {
        self.pieView.centerText = [NSString stringWithFormat:@"共%d个",rang];
    }
    
    if ([self.titleStr isEqualToString:@"项目收益"]) {
        self.pieView.centerText = [NSString stringWithFormat:@"共%d元",rang];
    }
    
}

#pragma mark - 开始时间选择
-(void)startTimeButtonAction
{
    self.clickButtonType = ClickButtonTypeStart;
    self.datepickerview.hidden = NO;
}

#pragma mark - 结束时间选择
-(void)endTimeButtonAction
{
    self.clickButtonType = ClickButtonTypeEnd;
    self.datepickerview.hidden = NO;
}

#pragma mark - 结束时间选择完成后调用-以区分调用哪个统计接口
-(void)confirmTimeWithInterface
{
    if ([self.titleStr isEqualToString:@"会员人数统计"]) {
        [self queryVipNumber];
    }
    if ([self.titleStr isEqualToString:@"剩余工位统计"]) {
        [self queryLongTimeBookStation];
    }
    
    if (strIsEmpty(self.startTimeStr)) {
        [MBProgressHUDUtil showMessage:@"请选择开始时间！" toView:self.view];
        return;
    }
    
    if (strIsEmpty(self.endTimeStr)) {
        [MBProgressHUDUtil showMessage:@"请选择结束时间！" toView:self.view];
        return;
    }
    
    if ([self.judgmentTime compareDate1:self.startTimeStr withDate:self.endTimeStr]) {
        [MBProgressHUDUtil showMessage:@"开始时间大于结束时间请重新选择" toView:self.view];
        return;
    }
    
    if ([self.titleStr isEqualToString:@"订单数量统计"]) {
        [self queryOrderNumber];
    }
    
    if ([self.titleStr isEqualToString:@"礼包数量统计"]) {
        [self queryGiftBag];
    }
    
    if ([self.titleStr isEqualToString:@"项目收益"]) {
        [self queryProjectEarnings];
    }
}

#pragma mark - 会员人数统计--请求
-(void)queryVipNumber
{

    if (self.parties.count) {
        [self.parties removeAllObjects];
        [self.parties addObject:@"普通会员"];
        [self.parties addObject:@"VIP会员"];
    }
    
    if (self.partiesValueS.count) {
        [self.partiesValueS removeAllObjects];
    }
    [WOTHTTPNetwork queryVipNumberWithSuccess:^(id bean) {
        SKVipNumberModel_msg *model = (SKVipNumberModel_msg *)bean;
        int sumNumber = 0;
        if ([model.code isEqualToString:@"200"]) {
            [self.partiesValueS addObject:model.msg.user];
            [self.partiesValueS addObject:model.msg.VIPuser];
            for (NSNumber *number in self.partiesValueS) {
                sumNumber += [number intValue];
            }
        }
        if (sumNumber == 0) {
            [self isShowNoInfoImageView];
        }else
        {
            [self isShowPieChart];
            [self setDataCount:self.parties.count range:sumNumber];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;

    }];
}

#pragma mark - 订单数量统计--请求
-(void)queryOrderNumber
{
    if (self.parties.count) {
        [self.parties removeAllObjects];
    }
    
    if (self.partiesValueS.count) {
        [self.partiesValueS removeAllObjects];
    }
    NSDictionary *dict = @{@"starTime":self.startTimeStr,@"endTime":self.endTimeStr};
    [WOTHTTPNetwork queryOrderNumberWithPict:dict success:^(id bean) {
        SKOrderNumberModel_msg *model_msg = (SKOrderNumberModel_msg *)bean;
        int sumNumber = 0;
        if ([model_msg.code isEqualToString:@"200"]) {
            for (SKOrderNumberModel *model in model_msg.msg ) {
                [self.parties addObject:model.CommodityKind];
                [self.partiesValueS addObject:model.num];
            }
            
            for (NSNumber *number in self.partiesValueS) {
                sumNumber += [number intValue];
            }
        }
        if (sumNumber == 0) {
            [self isShowNoInfoImageView];
        }else
        {
            [self isShowPieChart];
            [self setDataCount:self.parties.count range:sumNumber];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
        
    }];
}

#pragma mark - 礼包数量统计
-(void)queryGiftBag
{
    if (self.parties.count) {
        [self.parties removeAllObjects];
    }
    
    if (self.partiesValueS.count) {
        [self.partiesValueS removeAllObjects];
    }
    NSDictionary *dict = @{@"starTime":self.startTimeStr,@"endTime":self.endTimeStr};
    [WOTHTTPNetwork queryGiftBagNumberWithPict:dict success:^(id bean) {
        SKGiftBagNumberModel_msg *model_msg = (SKGiftBagNumberModel_msg *)bean;
        int sumNumber = 0;
        if ([model_msg.code isEqualToString:@"200"]) {
            for (SKGiftBagNumberModel *model in model_msg.msg ) {
                [self.parties addObject:model.giftName];
                [self.partiesValueS addObject:model.num];
            }
            
            for (NSNumber *number in self.partiesValueS) {
                sumNumber += [number intValue];
            }
        }
        if (sumNumber == 0) {
            [self isShowNoInfoImageView];
        }else
        {
            [self isShowPieChart];
            [self setDataCount:self.parties.count range:sumNumber];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 剩余工位统计
-(void)queryLongTimeBookStation
{
    if (self.parties.count) {
        [self.parties removeAllObjects];
        [self.parties addObject:@"剩余长租工位"];
        [self.parties addObject:@"剩余房间"];
    }
    
    if (self.partiesValueS.count) {
        [self.partiesValueS removeAllObjects];
    }
    NSDictionary *dict = nil;
    [WOTHTTPNetwork queryLongTimeBookStationWithPict:dict success:^(id bean) {
        SKResidueBookStationModel_msg *model_msg = (SKResidueBookStationModel_msg *)bean;
        int sumNumber = 0;
        if ([model_msg.code isEqualToString:@"200"]) {
            int bookStation = [model_msg.msg.jsonLong.N intValue] - [model_msg.msg.jsonLong.R intValue];
            [self.partiesValueS addObject:[NSNumber numberWithInt:bookStation]];
            int room = [model_msg.msg.jsonSubarea.N intValue] - [model_msg.msg.jsonSubarea.R intValue];
            [self.partiesValueS addObject:[NSNumber numberWithInt:room]];
            for (NSNumber *number in self.partiesValueS) {
                sumNumber += [number intValue];
            }
        }
        if (sumNumber == 0) {
            [self isShowNoInfoImageView];
        }else
        {
            [self isShowPieChart];
            [self setDataCount:self.parties.count range:sumNumber];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}
#pragma mark - 项目收益统计
-(void)queryProjectEarnings
{
    if (self.parties.count) {
        [self.parties removeAllObjects];
        [self.parties addObject:@"礼包"];
        [self.parties addObject:@"长租工位"];
        [self.parties addObject:@"账单"];
    }
    
    if (self.partiesValueS.count) {
        [self.partiesValueS removeAllObjects];
    }
    NSDictionary *dict = @{@"starTime":self.startTimeStr,@"endTime":self.endTimeStr};
    [WOTHTTPNetwork queryProjectEarningsWithPict:dict success:^(id bean) {
        SKProjectEarningsModel_msg *model_msg = (SKProjectEarningsModel_msg *)bean;
        int sumNumber = 0;
        if ([model_msg.code isEqualToString:@"200"]) {
            
            [self.partiesValueS addObject:model_msg.msg.giftMoney];
            [self.partiesValueS addObject:model_msg.msg.longMoney];
            [self.partiesValueS addObject:model_msg.msg.billMoney];
            for (NSNumber *number in self.partiesValueS) {
                sumNumber += [number intValue];
            }
        }
        if (sumNumber == 0) {
            [self isShowNoInfoImageView];
        }else
        {
            [self isShowPieChart];
            [self setDataCount:self.parties.count range:sumNumber];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 创建时间选择器
-(void)creatDataPickerView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSString *selecTime = [NSString stringWithFormat:@"%ld-%ld-%ld",year, month, day];
        if (self.clickButtonType == ClickButtonTypeEnd) {
             weakSelf.endTimeStr = [NSString stringWithFormat:@"%ld/%ld/%ld 23:59:59",year, month, day];
            [weakSelf.endTimeButton setTitle:selecTime forState:UIControlStateNormal];
            [weakSelf.endTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else
        {
            weakSelf.startTimeStr = [NSString stringWithFormat:@"%ld/%ld/%ld 00:00:00",year, month, day];
            [weakSelf.startTimeButton setTitle:selecTime forState:UIControlStateNormal];
            [weakSelf.startTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    };
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}

#pragma mark - 获取当前月份的开始和结束时间
-(void)getStartTimeAndEndTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM"];
    NSString *DateTime = [formatter stringFromDate:date];
    self.startTimeStr = [NSString stringWithFormat:@"%@/01 00:00:00",DateTime];
    
    self.endTimeStr = [NSString stringWithFormat:@"%@/%ld 23:59:59",DateTime,[self getNumberOfDaysInMonth]];
    
    NSDate *date1 = [NSDate date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"YYYY-MM"];
    NSString *DateTime1 = [formatter1 stringFromDate:date1];
    self.currentstartTimeStr = [NSString stringWithFormat:@"%@-01",DateTime1];
    
    self.currentendTimeStr = [NSString stringWithFormat:@"%@-%ld",DateTime1,[self getNumberOfDaysInMonth]];
}

- (NSInteger)getNumberOfDaysInMonth
{

    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
    NSDate * currentDate = [NSDate date];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:currentDate];
    return range.length;
}

#pragma mark - 显示饼状图-不显示无信息图
-(void)isShowPieChart
{
    self.pieView.hidden = NO;
    self.infoLabel.hidden = YES;
    self.infoImageView.hidden = YES;
}

#pragma mark - 显示无信息图-不显示饼状图
-(void)isShowNoInfoImageView
{
    self.pieView.hidden = YES;
    self.infoLabel.hidden = NO;
    self.infoImageView.hidden = NO;
}

-(PieChartView *)pieView
{
    if (!_pieView) {
        _pieView = [[PieChartView alloc] init];
        //_pieView.delegate = self;
        _pieView.noDataText = @"";
        //设置中间的饼状图距离四个边框的距离
        [_pieView setExtraOffsetsWithLeft:30 top:30 right:30 bottom:0];
        _pieView.usePercentValuesEnabled = YES;
        //_pieView.limitXLableSizeInSlice = YES;
        //设置图示
        ChartLegend *lg = _pieView.legend;
        lg.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
        lg.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        lg.orientation = ChartLegendOrientationHorizontal;
        lg.form = ChartLegendFormCircle;
        lg.formSize = 12;
        lg.formToTextSpace = 5;
        lg.drawInside = NO;
        lg.xEntrySpace = 10.0;
        lg.yEntrySpace = 10.0;
        lg.yOffset = 0.0;
        _pieView.entryLabelColor = UIColor.whiteColor;
        _pieView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
        [_pieView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    return _pieView;
}

-(UILabel *)startTimeLabel
{
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.text = @"开始时间:";
        _startTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _startTimeLabel;
}

-(UIButton *)startTimeButton
{
    if (!_startTimeButton) {
        _startTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startTimeButton addTarget:self action:@selector(startTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _startTimeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_startTimeButton setTitle:self.currentstartTimeStr forState:UIControlStateNormal];
        [_startTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startTimeButton.layer.cornerRadius = 5.f;
        _startTimeButton.layer.borderWidth = 1.f;
        _startTimeButton.layer.borderColor = UICOLOR_GRAY_66.CGColor;
    }
    return _startTimeButton;
}

-(UILabel *)endTimeLabel
{
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.text = @"结束时间:";
        _endTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _endTimeLabel;
}

-(UIButton *)endTimeButton
{
    if (!_endTimeButton) {
        _endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endTimeButton addTarget:self action:@selector(endTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _endTimeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_endTimeButton setTitle:self.currentendTimeStr forState:UIControlStateNormal];
        [_endTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _endTimeButton.layer.cornerRadius = 5.f;
        _endTimeButton.layer.borderWidth = 1.f;
        _endTimeButton.layer.borderColor = UICOLOR_GRAY_66.CGColor;
    }
    return _endTimeButton;
}

-(UIButton *)queryButton
{
    if (!_queryButton) {
        _queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_queryButton setTitle:@"查询" forState:UIControlStateNormal];
        _queryButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _queryButton.backgroundColor = UICOLOR_MAIN_ORANGE;
        [_queryButton addTarget:self action:@selector(confirmTimeWithInterface) forControlEvents:UIControlEventTouchUpInside];
        _queryButton.layer.cornerRadius = 5.f;
        _queryButton.layer.borderWidth = 1.f;
        _queryButton.layer.borderColor = UICOLOR_MAIN_ORANGE.CGColor;
    }
    return _queryButton;
}

-(UIImageView *)infoImageView
{
    if (!_infoImageView) {
        _infoImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
        _infoImageView.hidden = YES;
    }
    return _infoImageView;
}

-(UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"没有数据！";
        _infoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _infoLabel.textColor =[UIColor colorWithHue:0.00 saturation:0.00 brightness:0.57 alpha:1.00];
        _infoLabel.hidden = YES;
    }
    return _infoLabel;
}

-(JudgmentTime *)judgmentTime
{
    if (!_judgmentTime) {
        _judgmentTime = [[JudgmentTime alloc] init];
    }
    return _judgmentTime;
}

@end
