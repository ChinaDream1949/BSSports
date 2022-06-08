//
//  UIView+CPInitFaseView.h
//  baseXCode
//
//  Created by huashang on 2021/7/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CPInitFaseView)

//⚠️⚠️⚠️所属view调用 及添加到此view
//⚠️⚠️⚠️此文件的方法生成的view 都已经调用”addSubview“

/**
 生成一个uilabel
 @param title 显示文本
 @param font 字体
 @param textColor 文字颜色
 @param aligment 对齐方式
 */
-(UILabel*)LabInitT:(NSString*)title
                  F:(UIFont*)font
                 TC:(UIColor*)textColor
          alignment:(NSTextAlignment)aligment;

/**gif记载动画*/
//+(MBProgressHUD *)customizeShowLoading:(UIView *)view;

/**通用button*/
-(UIButton*)CustInitButton;

/**通用textfeild
 @param placeholder placeholder文字
 @param font 字体
 @param color 文字颜色
 */
-(WCPBaseTextField*)TFInitP:(NSString*)placeholder
                          F:(UIFont*)font
                         TC:(UIColor*)color;
/**构建imageview
 @param radius 圆角
 @param model UIViewContentMode模式
 @param cor 背景颜色
 */
-(UIImageView*)ImgViewInitR:(float)radius
                         CM:(UIViewContentMode )model
                         BC:(UIColor* __nullable)cor;


@end

NS_ASSUME_NONNULL_END
