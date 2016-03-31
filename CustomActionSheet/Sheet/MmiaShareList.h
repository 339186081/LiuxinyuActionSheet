//
//  MmiaShareList.h
//  CustomActionSheet
//
//  Created by liuxinyu on 15/8/31.
//  Copyright (c) 2015年 liuxinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareButtonDelegate <NSObject>

- (void)shareButtonClicked:(UIButton *)button;

@end

@interface MmiaShareList : UIView

@property (nonatomic,assign) id <ShareButtonDelegate> delegte;

- (instancetype)initShareListWithImageArray:(NSArray *)array;

- (void)showInView:(UIViewController *)vc;

@end
