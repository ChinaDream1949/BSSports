//
//  MBProgressHUD+NH.h
//  hetianqing
//
//  Created by 禾田青 on 2018/12/26.
//  Copyright © 2018年 htq. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN
#define Serverexceptiontext @"服务器或网络异常请稍后再试"
#define NSTimeIntervaltext 1.5
@interface MBProgressHUD (NH)
//加载动图

+ (void)showGifToView:(UIView *)view;
//+ (void)hideHUDForView:(UIView *)view;
/**
 
 *  快速从window中隐藏ProgressView
 
 */
+ (void)hideHUDview:(UIView *)view;
+ (void)hideHUD;
/** 提示i信息 */
+ (void)showMessageText:(NSString *)text  toView:(UIView *)view afterDelay:(NSTimeInterval)time;
/** 加载菊花 */
+ (void)showtoView:(UIView *)view;
/** 加载菊花 */
+ (void)showtoViewsame:(UIView *)view Text:(NSString *)text;
+ (void)hideHUDForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
