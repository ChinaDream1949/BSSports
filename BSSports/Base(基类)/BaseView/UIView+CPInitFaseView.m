//
//  UIView+CPInitFaseView.m
//  baseXCode
//
//  Created by huashang on 2021/7/24.
//

#import "UIView+CPInitFaseView.h"

@implementation UIView (CPInitFaseView)

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
          alignment:(NSTextAlignment)aligment
{
    UILabel * nameLab = [[UILabel alloc]init];
    nameLab.font = font;
    nameLab.text = title;
    nameLab.textColor = textColor;
    nameLab.textAlignment = aligment;
    
    [self addSubview:nameLab];
    
    return nameLab;
}

/**通用button*/
-(UIButton*)CustInitButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = NO;
    
    [self addSubview:btn];
    
    return btn;
}

/**通用textfeild
 @param placeholder placeholder文字
 @param font 字体
 @param color 文字颜色
 */
-(WCPBaseTextField*)TFInitP:(NSString*)placeholder
                          F:(UIFont*)font
                         TC:(UIColor*)color
{
    WCPBaseTextField *textfeild = [[WCPBaseTextField alloc]init];
    textfeild.placeholder = placeholder;
    textfeild.font = font;
    textfeild.textColor = color;

    [self addSubview:textfeild];
    
    return textfeild;
}

/**构建imageview
 @param radius 圆角
 @param model UIViewContentMode模式
 @param cor 背景颜色
 */
-(UIImageView*)ImgViewInitR:(float)radius
                         CM:(UIViewContentMode )model
                         BC:(UIColor* __nullable)cor;
{
    UIImageView *ImgV = [[UIImageView alloc]init];
    //    self.headerImg.backgroundColor = [UIColor redColor];
    ImgV.clipsToBounds = YES;
    ImgV.userInteractionEnabled = YES;
    ImgV.contentMode = UIViewContentModeScaleAspectFill;
    if (model) {
        ImgV.contentMode =  model;
    }
    if (radius) {
        ImgV.layer.cornerRadius = radius;
    }
    if (cor) {
        ImgV.backgroundColor = cor;
    }
    
    [self addSubview:ImgV];
    
    return ImgV;
}

@end
