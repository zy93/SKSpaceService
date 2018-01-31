//
//  SKMyCollectionReusableView.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/31.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKMyCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UIImageView *headerIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;

@end
