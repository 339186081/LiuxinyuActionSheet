//
//  ViewController.m
//  CustomActionSheet
//
//  Created by liuxinyu on 15/8/31.
//  Copyright (c) 2015年 liuxinyu. All rights reserved.
//

#import "ViewController.h"
#import "MmiaActionSheet.h"
#import "MmiaShareList.h"
@interface ViewController () <LXYSheetDelegate,ShareButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.view.center.x-50, 100, 100, 40);
    [btn addTarget:self action:@selector(showSheet:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 100;
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"点击分享" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(self.view.center.x-50, 180,100 , 40);
    [btn2 addTarget:self action:@selector(showSheet:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 101;
    [self.view addSubview:btn2];
}


- (void)showSheet:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
            MmiaActionSheet *sheet = [[MmiaActionSheet alloc]initLXYSheetWithArray:@[@"回复",@"点赞",@"复制",@"举报"]];
            sheet.delegate = self;
            [sheet showInView:self];
        }
            break;
            
        case 101:
        {
            MmiaShareList *sheet = [[MmiaShareList alloc]initShareListWithImageArray:@[@"homepage_classifyicon_tour",@"homepage_classifyicon_home",@"homepage_classifyicon_food",@"homepage_classifyicon_eduction"]];
            sheet.delegte = self;
            [sheet showInView:self];
        }
            break;
        default:
            break;
    }
}

- (void)selectedIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您选择了第%ld个",index] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)shareButtonClicked:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您选择分享的第%ld个",button.tag] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
