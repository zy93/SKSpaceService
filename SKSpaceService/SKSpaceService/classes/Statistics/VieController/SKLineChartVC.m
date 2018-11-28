//
//  SKLineChartVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 25/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKLineChartVC.h"
#import "SKSpaceService-Bridge-Header.h"
#import "WOTDatePickerView.h"
#import "JudgmentTime.h"
#import "SKFacilitatorModel.h"
#import "SKStatisticsOneFacilitatorModel.h"
#import "PickerView.h"
//#import ""
typedef NS_ENUM(NSInteger,ClickButtonType)
{
    ClickButtonTypeStart,
    ClickButtonTypeEnd
};
@interface SKLineChartVC ()<PickerViewResultDelegate>
@property (nonatomic,strong) LineChartView *lineChartView;
@property (nonatomic,strong) NSMutableArray <SKFacilitatorModel *>*facilitatorArray;
@property (nonatomic,strong) UILabel *startTimeLabel;
@property (nonatomic,strong) UIButton *startTimeButton;
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UIButton *endTimeButton;
@property (nonatomic,strong) UIButton *queryButton;
@property (nonatomic,strong) UILabel *selectfacilitatorLabel;
@property (nonatomic,strong) UIButton *selectfacilitatorButton;
@property (nonatomic,strong) UIImageView *infoImageView;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) JudgmentTime *judgmentTime;
@property (nonatomic,copy) NSString *currentstartTimeStr;
@property (nonatomic,copy) NSString *currentendTimeStr;
@property (nonatomic,copy) NSString *currentFacilitator;
@property (nonatomic,strong) NSNumber *facilitatorId;
@property (nonatomic,strong) NSMutableArray *facilitatorNameList;
@property (nonatomic,copy) NSString *startTimeStr;
@property (nonatomic,copy) NSString *endTimeStr;
@property (nonatomic, strong)WOTDatePickerView *datepickerview;
@property (nonatomic,assign) ClickButtonType clickButtonType;
@property (nonatomic,strong) NSMutableArray *xTitles;
@property (nonatomic,strong) PickerView *pickerView;
@end

@implementation SKLineChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务商点击次数统计";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getStartTimeAndEndTime];
    [self.view addSubview:self.lineChartView];
    [self.view addSubview:self.startTimeLabel];
    [self.view addSubview:self.startTimeButton];
    [self.view addSubview:self.endTimeLabel];
    [self.view addSubview:self.endTimeButton];
    [self.view addSubview:self.selectfacilitatorLabel];
    [self.view addSubview:self.selectfacilitatorButton];
    [self.view addSubview:self.queryButton];
    [self.view addSubview:self.infoImageView];
    [self.view addSubview:self.infoLabel];
    [self creatDataPickerView];
    self.xTitles = [[NSMutableArray alloc] init];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SCREEN_WIDTH);
    }];
    
    [self.selectfacilitatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectfacilitatorButton.mas_centerY);
        make.right.equalTo(self.selectfacilitatorButton.mas_left).with.offset(-5);
        //make.left.equalTo(self.view).with.offset(10);
        make.width.mas_offset(75);
    }];
    
    [self.selectfacilitatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeButton.mas_bottom).with.offset(15);
        
        make.right.equalTo(self.startTimeButton.mas_right);
        // make.width.mas_offset(150);
        make.width.mas_offset(100);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startTimeButton.mas_centerY);
        make.right.equalTo(self.startTimeButton.mas_left).with.offset(-5);
        make.width.mas_offset(60);
    }];
    
    [self.startTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineChartView.mas_top).with.offset(-50);
        make.right.equalTo(self.view.mas_centerX);
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
        make.top.equalTo(self.endTimeLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.endTimeLabel.mas_left);
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

#pragma mark - 显示饼状图-不显示无信息图
-(void)isShowLineChart
{
    self.lineChartView.hidden = NO;
    self.infoLabel.hidden = YES;
    self.infoImageView.hidden = YES;
}

#pragma mark - 显示无信息图-不显示饼状图
-(void)isShowNoInfoImageView
{
    self.lineChartView.hidden = YES;
    self.infoLabel.hidden = NO;
    self.infoImageView.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryAllFacilitator];
}

#pragma mark - 空间选择代理delegate
-(void)pickerView:(NSInteger)row result:(NSString *)string
{
//    if (self.selectButtonType == SelectButtonTypeSpace) {
//        WOTSpaceModel *model = self.spaceModelListArray[row];
//        [self querySomeSpaceBookStationWithModel:model withStr:string];
//    }
//    else
//    {
//        [self activityApplyStatisticsWith:string];
    [self.selectfacilitatorButton setTitle:string forState:UIControlStateNormal];
    self.facilitatorId = self.facilitatorArray[row].facilitatorId;
//    }
}

#pragma mark - 获取所有的服务商
-(void)queryAllFacilitator
{
    NSDictionary *dict = @{@"pageNo":@1,
                           @"pageSize":@1000,};
    [WOTHTTPNetwork queryAllFacilitatorWithPict:dict success:^(id bean) {
        SKFacilitatorModel_msg *model_msg = (SKFacilitatorModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            for (SKFacilitatorModel *model in model_msg.msg.list) {
                [self.facilitatorArray addObject:model];
                [self.facilitatorNameList addObject:model.firmName];
            }
            [self.selectfacilitatorButton setTitle:self.facilitatorArray.firstObject.firmName forState:UIControlStateNormal];
            self.facilitatorId = self.facilitatorArray.firstObject.facilitatorId;
            [self queryFacilitatorClickNumberWith];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        
    }];
}

#pragma mark - 查询方法
-(void)queryFacilitatorClickNumberWith
{
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
    
    NSDictionary *dict1 = @{@"starTime":self.startTimeStr,
                            @"endTime":self.endTimeStr,
                            @"facilitatorId":self.facilitatorId};
    [WOTHTTPNetwork queryStatisticsOneFacilitatorWithPict:dict1 success:^(id bean) {
        SKStatisticsOneFacilitatorModel_msg *model_msg = (SKStatisticsOneFacilitatorModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            if (self.xTitles.count>0) {
                [self.xTitles removeAllObjects];
            }
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (SKStatisticsOneFacilitatorModel *model in model_msg.msg) {
                [self.xTitles addObject:[model.date substringToIndex:11]];
                [dataArray addObject:model.num];
                
            }
           // self.lineChartView.xAxis.labelRotationAngle = -90;
            [self isShowLineChart];
            [self setData:dataArray];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 选择服务商-按钮
-(void)selectFacilitator
{
    self.pickerView = [[PickerView alloc] init];
    self.pickerView.delegate = self;
    [self.pickerView setSpaceData:self.facilitatorNameList withTitle:@"选择服务商"];
   
    [self.view addSubview:self.pickerView];
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

#pragma mark - 开始时间选择-按钮
-(void)startTimeButtonAction
{
    self.clickButtonType = ClickButtonTypeStart;
    self.datepickerview.hidden = NO;
}

#pragma mark - 结束时间选择-按钮
-(void)endTimeButtonAction
{
    self.clickButtonType = ClickButtonTypeEnd;
    self.datepickerview.hidden = NO;
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

-(NSMutableArray<SKFacilitatorModel *> *)facilitatorArray
{
    if (!_facilitatorArray) {
        _facilitatorArray = [[NSMutableArray alloc] init];
    }
    return _facilitatorArray;
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
        [_queryButton addTarget:self action:@selector(queryFacilitatorClickNumberWith) forControlEvents:UIControlEventTouchUpInside];
        _queryButton.layer.cornerRadius = 5.f;
        _queryButton.layer.borderWidth = 1.f;
        _queryButton.layer.borderColor = UICOLOR_MAIN_ORANGE.CGColor;
    }
    return _queryButton;
}

-(JudgmentTime *)judgmentTime
{
    if (!_judgmentTime) {
        _judgmentTime = [[JudgmentTime alloc] init];
    }
    return _judgmentTime;
}

-(UILabel *)selectfacilitatorLabel
{
    if (!_selectfacilitatorLabel) {
        _selectfacilitatorLabel = [[UILabel alloc] init];
        _selectfacilitatorLabel.text = @"选择服务商:";
        _selectfacilitatorLabel.textAlignment = NSTextAlignmentRight;
        _selectfacilitatorLabel.font = [UIFont systemFontOfSize:13];
    }
    return _selectfacilitatorLabel;
}

-(UIButton *)selectfacilitatorButton
{
    if (!_selectfacilitatorButton) {
        _selectfacilitatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectfacilitatorButton addTarget:self action:@selector(selectFacilitator) forControlEvents:UIControlEventTouchUpInside];
        _selectfacilitatorButton.titleLabel.font = [UIFont systemFontOfSize:13];
        //[_selectSpaceButton setTitle:self.spaceNameListArray[0]  forState:UIControlStateNormal];
        [_selectfacilitatorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectfacilitatorButton.layer.cornerRadius = 5.f;
        _selectfacilitatorButton.layer.borderWidth = 1.f;
        _selectfacilitatorButton.layer.borderColor = UICOLOR_GRAY_66.CGColor;
    }
    return _selectfacilitatorButton;
}

-(LineChartView *)lineChartView
{
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
        _lineChartView.noDataText = @"";
        // 设置交互样式
        _lineChartView.scaleYEnabled = NO;
        // 启用拖拽图标_chartView.dragDecelerationEnabled = YES;
        // 拖拽后是否有惯性效果(0~1)，数值越小，惯性越不明显
        _lineChartView.dragDecelerationFrictionCoef = 0.9;
        // 设置 X 轴样式
        ChartXAxis *xAxis =_lineChartView.xAxis;
        // xAxis.axisMaximum = self.xTitles.count-0.5;
        // 设置 X 轴的显示位置，默认是显示在上面的
        xAxis.labelPosition = XAxisLabelPositionBottom;
        // 设置 X 轴线宽
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        // 设置 X 轴颜色
        xAxis.axisLineColor = [UIColor blackColor];
        // 设置重复的值不显示
        xAxis.granularityEnabled = YES;
        // label 文字样式，自定义格式，默认时不显示特殊符号
        xAxis.valueFormatter = self;
        // label 文字颜色
        xAxis.labelTextColor = [UIColor blackColor];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.axisMinimum = -0.4;
        // 设置 Y 轴样式不绘制右边轴
        _lineChartView.rightAxis.enabled = NO;
        
        // 获取左边 Y 轴
        ChartYAxis *leftAxis =_lineChartView.leftAxis;
        //// 是否将 Y 轴进行上下翻转
        leftAxis.inverted = NO;
        // 设置 Y 轴线宽
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        // 设置 Y 轴颜色
        leftAxis.axisLineColor = [UIColor blackColor];
        // label 文字位置
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        // label 文字颜色
        leftAxis.labelTextColor = [UIColor blackColor];
        // 不强制绘制指定数量的 label
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        // 不强制绘制指定数量的 label
        leftAxis.forceLabelsEnabled = NO;
        // 设置虚线样式的网格线
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];
        // 网格线颜色
        //leftAxis.gridColor = XZLightGray;
        // 网格线开启抗锯齿
        leftAxis.gridAntialiasEnabled = YES;
        // 设置折线图描述
        _lineChartView.chartDescription.enabled = NO;
        // 设置折线图图例
        _lineChartView.legend.enabled = YES;
        // 设置动画效果，可以设置 X 轴和 Y 轴的动画效果
        [_lineChartView animateWithXAxisDuration:1.0f];
       
    }
    return _lineChartView;
}

-(NSNumber *)facilitatorId
{
    if (!_facilitatorId) {
        _facilitatorId = [[NSNumber alloc] init];
    }
    return _facilitatorId;
}

-(NSMutableArray *)facilitatorNameList
{
    if (!_facilitatorNameList) {
        _facilitatorNameList = [[NSMutableArray alloc] init];
    }
    return _facilitatorNameList;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    return self.xTitles[(NSInteger)value];
}

- (void)setData:(NSArray *)dataArr

{
    
    ChartXAxis *xAxis =_lineChartView.xAxis;
    
    xAxis.axisMaximum = self.xTitles.count-0.5;
    
    
    NSMutableArray *valueArray = [NSMutableArray array];
    
    [valueArray addObject:dataArr];
    
    NSMutableArray *dataSets = [NSMutableArray array];
    
    double leftAxisMin = 0;
    
    double leftAxisMax = 0;
    
    for (int i = 0; i < valueArray.count; i++) {
        NSArray *values = valueArray[i];
        NSMutableArray *yVals = [NSMutableArray array];
        for (int i = 0; i < values.count; i++)
        {
            NSString *valStr = [NSString stringWithFormat:@"%@", values[i]];
            double val = [valStr doubleValue];
            leftAxisMax = MAX(val, leftAxisMax);
            leftAxisMin = MIN(val, leftAxisMax);
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
            [yVals addObject:entry];
        }
        [_lineChartView setVisibleXRangeWithMinXRange:1 maxXRange:IS_IPHONE_5?3:4];
        LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:yVals label:@"点击次数"];
        
        dataSet.lineWidth = 2.0f;//折线宽度
        dataSet.drawValuesEnabled = YES;//是否在拐点处显示数据
        dataSet.valueColors = @[[UIColor blackColor]];//折线拐点处显示数据的颜色
        //dataSet.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        dataSet.drawCirclesEnabled = YES;//是否绘制拐点
        dataSet.cubicIntensity = 0.2;// 曲线弧度
        dataSet.circleRadius = 3.0f;//拐点半径
        dataSet.mode = LineChartModeCubicBezier;// 模式为曲线模式
        dataSet.axisDependency = AxisDependencyLeft;
        dataSet.circleHoleRadius = 2.0f;//空心的半径
        //dataSet.circleColors = @[XZBlueColor];//空心的圈的颜色
        //dataSet.circleHoleColor = XZWhiteColor;//空心的颜色
        dataSet.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        dataSet.highlightColor = [UIColor clearColor];
        dataSet.valueFont = [UIFont systemFontOfSize:12];
        dataSet.drawFilledEnabled = YES;//是否填充颜色
        // 设置渐变效果
        [dataSet setColor:[UIColor colorWithRed:0.114 green:0.812 blue:1.000 alpha:1.000]];//折线颜色
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#C4F3FF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        dataSet.fillAlpha = 1.0f;//透明度
        dataSet.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
        [dataSets addObject:dataSet];
    }
    double leftDiff = leftAxisMax - leftAxisMin;
    if (leftAxisMax == 0 && leftAxisMin == 0) {
        leftAxisMax = 100.0;
        leftAxisMin = 0;
    } else {
        leftAxisMax = (leftAxisMax + leftDiff * 0.2);
        leftAxisMin = (leftAxisMin - leftDiff * 0.1);
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    // if (leftAxisMax>=1000000) {
    //  numberFormatter.multiplier   = @0.000001;
    //  numberFormatter.positiveSuffix = @"M";
    // }else{
    //  numberFormatter.multiplier   = @0.001;
    //  numberFormatter.positiveSuffix = @"k";
    // }
   // numberFormatter.multiplier   = @0.001;
    
   // numberFormatter.positiveSuffix = @"K";
    
    self.lineChartView.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    
        
    
    self.lineChartView.leftAxis.axisMinimum = 0;//设置Y轴的最小值
    
   // self.lineChartView.leftAxis.axisMaximum = leftAxisMax;//设置Y轴的最大值
    
        
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    
    self.lineChartView.data = data;
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    
    pFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    // 小数位数(销量小数位0)
    
   // pFormatter.maximumFractionDigits = self.M.isCuv?0:2;
  
    
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    
    
    
    [self.lineChartView animateWithYAxisDuration:0.3f];
    
}


@end
