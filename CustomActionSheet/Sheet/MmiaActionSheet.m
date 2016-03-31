//
//  LXYSheet.m
//  PULLView
//
//  Created by lxy on 15/3/5.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "MmiaActionSheet.h"
#import "SheetCell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define Spacing 10
#define CELL_HEIGHT 60
#define SHARE_HEIGHT 160
@interface MmiaActionSheet () <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *table;
    NSArray *dataArray;
}

@end

@implementation MmiaActionSheet


- (instancetype)initLXYSheetWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:79/255.0 green:93/255.0 blue:97/255.0 alpha:0];
        
        dataArray = [NSArray arrayWithArray:array];
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, CELL_HEIGHT*dataArray.count+Spacing*2+CELL_HEIGHT+20) style:UITableViewStyleGrouped];
        
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


// -----------------------------------------------
#pragma mark - table delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, 1)];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        return view;
    }
    else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    
    SheetCell *cell = [table dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SheetCell" owner:self options:nil]lastObject];
        
    }
    
    
    if (indexPath.section==0) {
        cell.nameLabel.text = [dataArray objectAtIndex:indexPath.row];
        
    }
    else {
        cell.nameLabel.text = @"取消";
        cell.nameLabel.font = [UIFont systemFontOfSize:22];
        cell.nameLabel.textColor = [UIColor redColor];
        cell.nameLabel.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return dataArray.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CELL_HEIGHT+20;
    }
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:indexPath.row];
    }
    [self dismissTable];
}

@end
