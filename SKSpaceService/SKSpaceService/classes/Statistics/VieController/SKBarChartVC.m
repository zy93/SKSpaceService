//
//  SKBarChartVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 21/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKBarChartVC.h"
#import "SKSpaceService-Bridge-Header.h"
#import "XAxisValueFormatter.h"
#import "WOTSpaceModel.h"
#import "PickerView.h"
#import "WOTDatePickerView.h"
#import "JudgmentTime.h"
#import "WOTSpaceModel.h"
#import "SKResidueBookStationModel.h"
#import "SKAllSpaceCompanyModel.h"
#import "SKAllSpaceBookStationModel.h"
#import "SKFacilitatorTopModel.h"
#import "SKActivityApplyModel.h"

typedef NS_ENUM(NSInteger,ClickButtonType)
{
    ClickButtonTypeStart,
    ClickButtonTypeEnd
};

typedef NS_ENUM(NSInteger,SelectButtonType)
{
    SelectButtonTypeSpace,
    SelectButtonTypeactivityState
};

@interface SKBarChartVC ()<IChartAxisValueFormatter,PickerViewResultDelegate>
@property (nonatomic,strong) BarChartView *barView;
@property (nonatomic,strong) NSMutableArray *xVals;
@property (nonatomic,copy)NSArray *graphicalArray;
@property (nonatomic,copy) NSArray *colorArray;
@property (nonatomic,strong) PickerView *pickerView;
@property (nonatomic,strong) UILabel *selectSpaceLabel;
@property (nonatomic,strong) UIButton *selectSpaceButton;
@property (nonatomic,strong) UILabel *startTimeLabel;
@property (nonatomic,strong) UIButton *startTimeButton;
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UIButton *endTimeButton;
@property (nonatomic,strong) UIButton *queryButton;
@property (nonatomic,strong) UIImageView *infoImageView;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic, strong)WOTDatePickerView *datepickerview;
@property (nonatomic,copy) NSString *currentstartTimeStr;
@property (nonatomic,copy) NSString *currentendTimeStr;
@property (nonatomic,copy) NSString *startTimeStr;
@property (nonatomic,copy) NSString *endTimeStr;
@property (nonatomic,assign) ClickButtonType clickButtonType;
@property (nonatomic,assign) SelectButtonType selectButtonType;
@property (nonatomic,strong) JudgmentTime *judgmentTime;
@property (nonatomic,strong) NSMutableArray *spaceNameListArray;
@property (nonatomic,strong) NSArray <WOTSpaceModel *> *spaceModelListArray;
@property (nonatomic,strong) NSMutableArray *activityStateArray;
@end

@implementation SKBarChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    [self getStartTimeAndEndTime];
    
    [self.view addSubview:self.barView];
    [self.view addSubview:self.selectSpaceLabel];
    [self.view addSubview:self.selectSpaceButton];
    [self.view addSubview:self.startTimeLabel];
    [self.view addSubview:self.startTimeButton];
    [self.view addSubview:self.endTimeLabel];
    [self.view addSubview:self.endTimeButton];
    [self.view addSubview:self.queryButton];
    [self.view addSubview:self.infoImageView];
    [self.view addSubview:self.infoLabel];
    [self layoutSubviews];
    [self creatDataPickerView];
    [self isShowButton];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self confirmTimeWithInterface];
}

-(void)layoutSubviews
{
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SCREEN_WIDTH);
    }];
    
    [self.selectSpaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectSpaceButton.mas_centerY);
        //make.right.equalTo(self.view.mas_centerX).with.offset(-10);
        make.left.equalTo(self.view).with.offset(10);
        make.width.mas_offset(85);
    }];
    
    [self.selectSpaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.barView.mas_top).with.offset(-50);
        make.left.equalTo(self.selectSpaceLabel.mas_right).with.offset(5);
       // make.width.mas_offset(150);
        
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startTimeButton.mas_centerY);
        make.right.equalTo(self.startTimeButton.mas_left).with.offset(-5);
        make.width.mas_offset(60);
    }];

    [self.startTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.barView.mas_top).with.offset(-50);
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
    if ([self.titleStr isEqualToString:@"服务商点击Top10统计"]) {
        self.startTimeLabel.hidden = NO;
        self.startTimeButton.hidden = NO;
        self.endTimeLabel.hidden = NO;
        self.endTimeButton.hidden = NO;
        self.queryButton.hidden = NO;
    }else
    {
        
        self.startTimeLabel.hidden = YES;
        self.startTimeButton.hidden = YES;
        self.endTimeLabel.hidden = YES;
        self.endTimeButton.hidden = YES;
        self.queryButton.hidden = YES;
    }
    
    if ([self.titleStr isEqualToString:@"空间工位统计"] || [self.titleStr isEqualToString:@"活动报名统计"]) {
        self.selectSpaceLabel.hidden = NO;
        self.selectSpaceButton.hidden = NO;
    } else {
        self.selectSpaceLabel.hidden = YES;
        self.selectSpaceButton.hidden = YES;
    }
    
}

#pragma mark - 显示饼状图-不显示无信息图
-(void)isShowBarChart
{
    self.barView.hidden = NO;
    self.infoLabel.hidden = YES;
    self.infoImageView.hidden = YES;
}

#pragma mark - 显示无信息图-不显示饼状图
-(void)isShowNoInfoImageView
{
    self.barView.hidden = YES;
    self.infoLabel.hidden = NO;
    self.infoImageView.hidden = NO;
}

#pragma mark - 空间选择代理delegate
-(void)pickerView:(NSInteger)row result:(NSString *)string
{
    if (self.selectButtonType == SelectButtonTypeSpace) {
        WOTSpaceModel *model = self.spaceModelListArray[row];
        [self querySomeSpaceBookStationWithModel:model withStr:string];
    }
    else
    {
        [self activityApplyStatisticsWith:string];
    }
}

#pragma mark - 获取所有的空间
-(void)getAllSpace
{
    [WOTHTTPNetwork getSapaceWithPage:@1 pageSize:@100 success:^(id bean) {
        WOTSpaceModel_msg *model_msg = (WOTSpaceModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.spaceModelListArray = model_msg.msg.list;
            for (WOTSpaceModel *model in self.spaceModelListArray) {
                [self.spaceNameListArray addObject:model.spaceName];
            }
          [self.selectSpaceButton setTitle:self.spaceNameListArray[0] forState:UIControlStateNormal];
            [self querySomeSpaceBookStationWithModel:self.spaceModelListArray.firstObject withStr:self.spaceNameListArray.firstObject];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        
    }];
}

#pragma mark - 选择空间方法
-(void)selectSpaceButtonAction
{
    self.pickerView = [[PickerView alloc] init];
    self.pickerView.delegate = self;
    if (self.selectButtonType == SelectButtonTypeSpace) {
        [self.pickerView setSpaceData:self.spaceNameListArray withTitle:@"选择空间"];
    }
    else
    {
        [self.pickerView setSpaceData:self.activityStateArray withTitle:@"选择活动状态"];
    }
    [self.view addSubview:self.pickerView];
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
    
    if ([self.titleStr isEqualToString:@"空间工位统计"]) {
        self.selectButtonType = SelectButtonTypeSpace;
        _selectSpaceLabel.text = @"选择空间:";
        [self getAllSpace];
    }
    if ([self.titleStr isEqualToString:@"空间企业统计"]) {
        [self queryAllSpaceCompany];
    }
    
    if ([self.titleStr isEqualToString:@"所有空间工位统计"]) {
        [self queryAllSpaceBookStationNumber];
    }
    
    if ([self.titleStr isEqualToString:@"活动报名统计"]) {
        self.selectButtonType = SelectButtonTypeactivityState;
        _selectSpaceLabel.text = @"选择活动状态:";
        [self.selectSpaceButton setTitle:self.activityStateArray[1] forState:UIControlStateNormal];
        [self activityApplyStatisticsWith:self.activityStateArray[1]];
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
    
    if ([self.titleStr isEqualToString:@"服务商点击Top10统计"]) {
        [self queryFacilitatorTopTen];
    }
    
}


#pragma mark - 空间工位统计
-(void)querySomeSpaceBookStationWithModel:(WOTSpaceModel *)model withStr:(NSString *)string
{
    [self.selectSpaceButton setTitle:string forState:UIControlStateNormal];
    NSDictionary *dict = @{@"spaceId":model.spaceId};
    [WOTHTTPNetwork queryLongTimeBookStationWithPict:dict success:^(id bean) {
        SKResidueBookStationModel_msg *model_msg = (SKResidueBookStationModel_msg *)bean;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSMutableArray *oneGroupData = [[NSMutableArray alloc] init];
        NSMutableArray *twoGroupData = [[NSMutableArray alloc] init];
        if ([model_msg.code isEqualToString:@"200"]) {
            [oneGroupData addObject:model_msg.msg.jsonLong.N];
            [oneGroupData addObject:model_msg.msg.jsonShort.N];
            [oneGroupData addObject:model_msg.msg.jsonSubarea.N];
            [twoGroupData addObject:model_msg.msg.jsonLong.R];
            [twoGroupData addObject:model_msg.msg.jsonShort.R];
            [twoGroupData addObject:model_msg.msg.jsonSubarea.R];
            NSString *oneStr = [NSString stringWithFormat:@"长租工位出租率%.2f%%",[model_msg.msg.jsonLong.rate floatValue]*100];
            NSString *twoStr = [NSString stringWithFormat:@"临时工位出租率%.2f%%",[model_msg.msg.jsonShort.rate floatValue]*100];
            NSString *threeStr = [NSString stringWithFormat:@"房间出租率%.2f%%",[model_msg.msg.jsonSubarea.rate floatValue]*100];
            if (self.xVals.count > 0) {
                [self.xVals removeAllObjects];
            }
            [self.xVals addObject:oneStr];
            [self.xVals addObject:twoStr];
            [self.xVals addObject:threeStr];
            [dataArray addObject:oneGroupData];
            [dataArray addObject:twoGroupData];
        }
        self.graphicalArray = @[@"总数",@"已出租"];
        [self isShowBarChart];
        [self setDataCount:3 withDataArray:dataArray];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 空间企业统计
-(void)queryAllSpaceCompany
{
    [WOTHTTPNetwork statisticsAllSpaceCompanyWithSuccess:^(id bean) {
        SKAllSpaceCompanyModel_msg *model_msg = (SKAllSpaceCompanyModel_msg *)bean;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSMutableArray *oneGroupData = [[NSMutableArray alloc] init];
        if ([model_msg.code isEqualToString:@"200"]) {
            if (self.xVals.count >0) {
                [self.xVals removeAllObjects];
            }
            for (SKAllSpaceCompanyModel *model in model_msg.msg) {
                [oneGroupData addObject:model.companyNum];
                [self.xVals addObject:model.spaceName];
            }
        }
        [dataArray addObject:oneGroupData];
        self.barView.xAxis.labelRotationAngle = -90;
        self.graphicalArray = @[@"企业数量"];
        [self isShowBarChart];
        [self setDataCount:(int)self.xVals.count withDataArray:dataArray];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 空间工位统计-总体
-(void)queryAllSpaceBookStationNumber
{
    [WOTHTTPNetwork queryAllSpaceBookStationNumberyWithSuccess:^(id bean) {
        SKAllSpaceBookStationModel_msg *model_msg = (SKAllSpaceBookStationModel_msg *)bean;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSMutableArray *oneGroupData = [[NSMutableArray alloc] init];
        NSMutableArray *twoGroupData = [[NSMutableArray alloc] init];
        NSMutableArray *threeGroupData = [[NSMutableArray alloc] init];
        if ([model_msg.code isEqualToString:@"200"]) {
            if (self.xVals.count >0) {
                [self.xVals removeAllObjects];
            }
            for (SKAllSpaceBookStationModel *model in model_msg.msg) {
                [oneGroupData addObject:model.LongNum];
                [twoGroupData addObject:model.ShortNum];
                [threeGroupData addObject:model.subareaNum];
                [self.xVals addObject:model.spaceName];
            }
        }
        [dataArray addObject:oneGroupData];
        [dataArray addObject:twoGroupData];
        [dataArray addObject:threeGroupData];
        self.barView.xAxis.labelRotationAngle = -90;
        self.graphicalArray = @[@"长租工位",@"临时工位",@"房间"];
        [self isShowBarChart];
        [self setDataCount:(int)self.xVals.count withDataArray:dataArray];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 服务商点击Top10统计
-(void)queryFacilitatorTopTen
{
    NSDictionary *dict = @{@"starTime":self.startTimeStr,@"endTime":self.endTimeStr};
    [WOTHTTPNetwork queryFacilitatorTopWithPict:dict success:^(id bean) {
        SKFacilitatorTopModel_msg *model_msg = (SKFacilitatorTopModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            NSMutableArray *oneGroupData = [[NSMutableArray alloc] init];
            if ([model_msg.code isEqualToString:@"200"]) {
                if (self.xVals.count >0) {
                    [self.xVals removeAllObjects];
                }
                for (SKFacilitatorTopModel *model in model_msg.msg) {
                    [oneGroupData addObject:model.num];
                    NSString *titleStr;
                    if (model.firmName.length > 10) {
                        titleStr = [model.firmName substringToIndex:11];
                    }else
                    {
                        titleStr = model.firmName;
                    }
                    [self.xVals addObject:titleStr];
                }
            }
            [dataArray addObject:oneGroupData];
            self.barView.xAxis.labelRotationAngle = -90;
            self.graphicalArray = @[@"点击次数"];
            [self isShowBarChart];
            [self setDataCount:(int)self.xVals.count withDataArray:dataArray];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

#pragma mark - 活动报名统计
-(void)activityApplyStatisticsWith:(NSString *)stateStr
{
    [self.selectSpaceButton setTitle:stateStr forState:UIControlStateNormal];
    if ([stateStr isEqualToString:@"已结束"]) {
        stateStr = @"以结束";
    }else
    {
        stateStr = @"进行中";
    }
    
    NSDictionary *dict = @{@"state":stateStr};
    [WOTHTTPNetwork activityApplyStatisticsWithPict:dict success:^(id bean) {
        SKActivityApplyModel_msg *model_msg = (SKActivityApplyModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            NSMutableArray *oneGroupData = [[NSMutableArray alloc] init];
            if ([model_msg.code isEqualToString:@"200"]) {
                if (self.xVals.count >0) {
                    [self.xVals removeAllObjects];
                }
                for (SKActivityApplyModel *model in model_msg.msg) {
                    [oneGroupData addObject:model.num];
                    NSString *titleStr;
                    if (model.title.length > 10) {
                        titleStr = [model.title substringToIndex:11];
                    }else
                    {
                        titleStr = model.title;
                    }
                    [self.xVals addObject:titleStr];
                }
            }
            [dataArray addObject:oneGroupData];
            self.barView.xAxis.labelRotationAngle = -90;
            self.graphicalArray = @[@"报名人数"];
            if (self.xVals.count > 0) {
                [self isShowBarChart];
                [self setDataCount:(int)self.xVals.count withDataArray:dataArray];
            }
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self isShowNoInfoImageView];
        self.infoLabel.text = errorMessage;
    }];
}

-(BarChartView *)barView
{
    if (!_barView) {
        _barView = [[BarChartView alloc] init];
        _barView.noDataText = @"";//没有数据时的文字提示

        _barView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        
        ChartXAxis *xAxis = _barView.xAxis;
        xAxis.valueFormatter = self;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelFont = [UIFont systemFontOfSize:9];
        //xAxis.centerAxisLabelsEnabled = YES;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.drawAxisLineEnabled = YES;

        ChartYAxis *leftAxis = _barView.leftAxis;//获取左边Y轴
        leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.35;//Y轴线宽
        leftAxis.forceLabelsEnabled = YES;
//        leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.axisMinimum = 0;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
        
       // leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        _barView.rightAxis.enabled = NO;
        _barView.legend.enabled = YES;//不显示图例说明
    }
    return _barView;
}

- (void)setDataCount:(int)count withDataArray:(NSMutableArray *)dataArray
{
    
    int va1 = 0;
    int va2 = 0;
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    for (int i = 0;i < dataArray.count; i++) {
        NSArray *arr = dataArray[i];
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int j = 0; j < arr.count; j++) {
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:j y:[arr[j] doubleValue]];
            [yVals addObject:entry];
            va1++;
        }
        BarChartDataSet *set = [[BarChartDataSet alloc] initWithValues:yVals label:self.graphicalArray[i]];
        [set setColor:self.colorArray[i]];
        [dataSets addObject:set];
        va2++;
    }
    NSLog(@"循环次数%d,  %d",va1,va2);
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    //设置宽度   柱形之间的间隙占整个柱形(柱形+间隙)的比例
    if (dataArray.count == 3) {
        [data setBarWidth:0.25];
        [data groupBarsFromX: -0.5 groupSpace: 0.25 barSpace: 0];
    }else
    {
        [data setBarWidth:0.4];
        [data groupBarsFromX: -0.5 groupSpace: 0.2 barSpace: 0];
    }
    
    
    [data setValueFont:[UIFont systemFontOfSize:9]];//文字字体
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];

    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    ChartDefaultValueFormatter  *forma =
    [[ChartDefaultValueFormatter alloc] initWithFormatter:formatter];
    [data setValueFormatter:forma];
    
    _barView.data = data;
    //设置如何数据多可滚动
    [_barView setVisibleXRangeMaximum:6];//一定要设置在_barView.data = data;的后面
}

//x标题
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return  self.xVals[(int)value];
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

-(NSArray *)colorArray
{
    if (!_colorArray) {
       _colorArray = @[[UIColor colorWithHue:0.56 saturation:0.76 brightness:0.84 alpha:1.00],[UIColor redColor],[UIColor colorWithHue:0.52 saturation:0.41 brightness:0.65 alpha:1.00]];
    }
    return _colorArray;
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

-(UILabel *)selectSpaceLabel
{
    if (!_selectSpaceLabel) {
        _selectSpaceLabel = [[UILabel alloc] init];
        _selectSpaceLabel.hidden = YES;
//        _selectSpaceLabel.text = @"选择空间:";
        _selectSpaceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _selectSpaceLabel;
}

-(UIButton *)selectSpaceButton
{
    if (!_selectSpaceButton) {
        _selectSpaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectSpaceButton.hidden = YES;
        [_selectSpaceButton addTarget:self action:@selector(selectSpaceButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _selectSpaceButton.titleLabel.font = [UIFont systemFontOfSize:13];
        //[_selectSpaceButton setTitle:self.spaceNameListArray[0]  forState:UIControlStateNormal];
        [_selectSpaceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectSpaceButton.layer.cornerRadius = 5.f;
        _selectSpaceButton.layer.borderWidth = 1.f;
        _selectSpaceButton.layer.borderColor = UICOLOR_GRAY_66.CGColor;
    }
    return _selectSpaceButton;
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

-(JudgmentTime *)judgmentTime
{
    if (!_judgmentTime) {
        _judgmentTime = [[JudgmentTime alloc] init];
    }
    return _judgmentTime;
}

-(NSMutableArray *)spaceNameListArray
{
    if (!_spaceNameListArray) {
        _spaceNameListArray = [[NSMutableArray alloc] init];
    }
    return _spaceNameListArray;
}

-(NSArray<WOTSpaceModel *> *)spaceModelListArray
{
    if (!_spaceModelListArray) {
        _spaceModelListArray = [[NSMutableArray alloc] init];
    }
    return _spaceModelListArray;
}

-(NSMutableArray *)xVals
{
    if (!_xVals) {
        _xVals = [[NSMutableArray alloc] init];
    }
    return _xVals;
}

-(NSMutableArray *)activityStateArray
{
    if (!_activityStateArray) {
        _activityStateArray = [[NSMutableArray alloc] init];
        [_activityStateArray addObject:@"进行中"];
        [_activityStateArray addObject:@"已结束"];
    }
    return _activityStateArray;
}

@end
