//
//  SKLogContentCell.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKLogContentCell;

@protocol SKLogContentCellDelegate <NSObject>
-(void)logContentCell:(SKLogContentCell *)cell addBtnClick:(id)sender;
@end


@interface SKLogContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *addLogBtn;

@property (nonatomic, strong) id <SKLogContentCellDelegate> delegate;

@end
