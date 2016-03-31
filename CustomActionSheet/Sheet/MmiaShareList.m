//
//  MmiaShareList.m
//  CustomActionSheet
//
//  Created by liuxinyu on 15/8/31.
//  Copyright (c) 2015年 liuxinyu. All rights reserved.
//

#import "MmiaShareList.h"
#import "SheetCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ShareHeight 150

#define Marigin 32
#define Share_Button_Width 60
#define CancelHeight 80
#define Button_Tag 100
@interface MmiaShareList () <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    NSArray *dataArray;
    
    UITableView *table;

    UIScrollView *shareScroll;
}

@end

@implementation MmiaShareList

- (instancetype)initShareListWithImageArray:(NSArray *)array
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:79/255.0 green:93/255.0 blue:97/255.0 alpha:0];
        
        dataArray = [NSArray arrayWithArray:array];
        
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ShareHeight+CancelHeight) style:UITableViewStylePlain];
        
        table.delegate = self;
        table.dataSource = self;
        table.scrollEnabled = NO;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:table];

    
        [self addGesture];
        [self showTable];
    }
    return self;
}

/**
 *  添加手势
 */
- (void)addGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    
    tapGesture.delegate = self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}
/**
 *  手势取消
 */
- (void)tappedCancel
{
    
    [self dismissTable];
}

#pragma mark -table 的显示与隐藏
- (void)showTable
{
    
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:79/255.0 green:93/255.0 blue:97/255.0 alpha:0.3];
        
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [table setFrame:CGRectMake(table.frame.origin.x, ScreenHeight-table.frame.size.height, table.frame.size.width, table.frame.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
    }];
    
    
}

- (void)dismissTable
{
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [table setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        
        [table removeFromSuperview];
        table = nil;
        [self removeFromSuperview];
        
    }];
}



#pragma mark - table delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    shareScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ShareHeight)];
    shareScroll.showsHorizontalScrollIndicator = NO;
    
    for (int i=0; i<dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[dataArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(Marigin+i*(Marigin+Share_Button_Width), Marigin, Share_Button_Width, Share_Button_Width);
        [shareScroll addSubview:btn];
        
        btn.tag = Button_Tag;
    }
    NSInteger count = dataArray.count;
    shareScroll.contentSize = CGSizeMake(count*(Share_Button_Width+Marigin)+Marigin, 0);
    return shareScroll;
}

#pragma mark - shareClicked
- (void)buttonClick:(UIButton *)btn
{
    if ([self.delegte respondsToSelector:@selector(shareButtonClicked:)]) {
        [self.delegte shareButtonClicked:btn];
    }
    [self dismissTable];
}

#pragma mark - 添加到当前界面
- (void)showInView:(UIViewController *)vc
{
    if (vc == nil) {
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }
    else {
        [vc.view addSubview:self];
    }
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ShareHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    
    SheetCell *cell = [table dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SheetCell" owner:self options:nil]lastObject];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 1)];
        lineView.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:lineView];
    }
    
    cell.nameLabel.text = @"取消";
    cell.nameLabel.font = [UIFont systemFontOfSize:22];
    cell.nameLabel.textColor = [UIColor redColor];
    cell.nameLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self dismissTable];
}

@end
