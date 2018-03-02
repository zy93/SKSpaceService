//
//  SKSelectIdentityView.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/1.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSelectIdentityView.h"

#define selectIdentityViewX 90
#define selectButtonHeight  55


@interface SKSelectIdentityView()
{
    NSArray *buttonTitles;
    NSMutableArray *buttonList;
    UIView *backgroundView;
    UIView *contentView;
}
@end


@implementation SKSelectIdentityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        buttonTitles = titles;
        [self createSubview];
    }
    return self;
}

-(void)createSubview
{
    backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5f;
    [self addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showView)];
    [backgroundView addGestureRecognizer:tap];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-(2*selectIdentityViewX), buttonTitles.count*selectButtonHeight)];
    contentView.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5.f;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    
    int index = 0;
    for (NSString *title in buttonTitles) {
        [self createButtonWithTitle:title index:index];
        index++;
    }
    
}

-(void)createButtonWithTitle:(NSString *)title index:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, index*selectButtonHeight, contentView.frame.size.width, selectButtonHeight)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:button];
    if (index!=0 || index!=buttonList.count-1) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 1)];
        line.backgroundColor = [UIColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1.f];
        [contentView addSubview:line];
    }
}

#pragma mark - public methods
-(void)showView
{
    BOOL bOldStatus = self.hidden;
    CGFloat fAlpha = (bOldStatus == YES) ? 1 : 0;
    CGFloat fyPos = (bOldStatus == YES) ? -(200*[WOTUitls GetLengthAdaptRate]) : 0;
    self.hidden = NO;
    __weak UIView *pWeakSelf = contentView;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = fAlpha;
//                         pWeakSelf.transform = CGAffineTransformMakeTranslation(0, fyPos);
                     }
                     completion:^(BOOL finished) {
                         self.hidden = !bOldStatus;
                     }];
}


-(void)buttonClick:(UIButton *)sender
{
    [self showView];
    if ([_delegate respondsToSelector:@selector(selectIdentityView:selectIndentity:)]) {
        
        [_delegate selectIdentityView:self selectIndentity:sender.titleLabel.text];
    }
}

@end
