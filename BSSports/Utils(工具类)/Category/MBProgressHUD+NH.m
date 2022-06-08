//
//  MBProgressHUD+NH.m
//  hetianqing
//
//  Created by 禾田青 on 2018/12/26.
//  Copyright © 2018年 htq. All rights reserved.
//

#import "MBProgressHUD+NH.h"
#import "UIImage+GIF.h"
@implementation MBProgressHUD (NH)
//1.显示加载动画的方法！
+ (void)showGifToView:(UIView *)view{
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！i
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    
    //    NSURL *url = [NSURL fileURLWithPath:@"/Users/hetianqing/Desktop/禾田青/hetianqing/hetianqing/Alldocuments/ImagesAlls/禾田青loading.gif"];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"禾田青loading" ofType:@"gif"]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //使用SDWebImage 放入gif 图片--(因为项目中使用的都是同一个加载动画，所以在这里我把图片写死了)
//    UIImage *image = [UIImage sd_animatedGIFWithData:gifData];
//    //自定义imageView
//    UIImageView *cusImageV = [[UIImageView alloc] initWithImage:image];
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    //设置提示性文字
    //    hud.label.text = @"正在加载中";
    //    // 设置文字大小
    //    hud.label.font = [UIFont systemFontOfSize:20];
    //    //设置文字的背景颜色
    //    //    hud.label.backgroundColor = [UIColor redColor];
    //
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    //设置总背景view的背景色，并带有透明效果
    //    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//    hud.customView = cusImageV;
    
}

//隐藏加载动画的方法
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}
+ (void)hideHUD{
    [self hideHUDForView:nil];
    
}
+ (void)hideHUDview:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}
+ (void)showMessageText:(NSString *)text  toView:(UIView *)view afterDelay:(NSTimeInterval)time
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
//    hud.label.font=sFONT(28);
    hud.detailsLabel.font = PFReFONT(15);
    hud.mode = MBProgressHUDModeText;
//    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.detailsLabel.textColor=[UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
//    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
    
}
+ (void)showtoView:(UIView *)view
{
   if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.margin = 7;//修改该值，可以修改加载框大小
//    hud.mode = MBProgressHUDModeIndeterminate;
    //背景颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:.2f];
    
//    //设置菊花框为白色 activityIndicatorColor
    //hud.activityIndicatorColor = [UIColor colorWithRed:246/255.0 green:8/255.0 blue:142/255.0 alpha:1];
    //hud.opacity = 1;
//    hud.square = YES;//等宽高
//    hud.margin = 7;//修改该值，可以修改加载框大小
//    hud.removeFromSuperViewOnHide = YES;
//    [hud showAnimated:YES];

}
/** 加载菊花 */
+ (void)showtoViewsame:(UIView *)view Text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    //背景颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:.2f];
     hud.label.textColor=[UIColor whiteColor];
}

@end
