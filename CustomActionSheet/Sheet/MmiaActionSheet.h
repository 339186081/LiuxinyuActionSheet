//
//  LXYSheet.h
//  PULLView
//
//  Created by lxy on 15/3/5.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXYSheetDelegate <NSObject>

- (void)selectedIndex:(NSInteger)index;

@end

@interface MmiaActionSheet : UIView

@property (nonatomic,assign) id <LXYSheetDelegate>delegate;


- (instancetype)initLXYSheetWithArray:(NSArray *)array;

- (void)showInView:(UIViewController *)vc;

@end
