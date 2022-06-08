//
//  ViewConstructor.m
//  yunbaolive
//
//  Created by __ on 2020/12/15.
//  Copyright © 2020 cat. All rights reserved.
//


@interface wcpBtn : UIButton

@end
@implementation wcpBtn
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 当前btn的大小
    CGRect btnBounds=self.bounds;
    // 扩大按钮的点击范围，改为负值
    btnBounds=CGRectInset(btnBounds, -10, -10);
    // 若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}
@end


@implementation ViewConstructor
+(UILabel*)LableInitTitle:(NSString*)title
                 font:(UIFont*)font
            textColor:(UIColor*)textColor
            alignment:(NSTextAlignment)aligment
{
    UILabel * nameLab = [[UILabel alloc]init];
    nameLab.font = font;
    nameLab.text = title;
    nameLab.textColor = textColor;
    nameLab.textAlignment = aligment;
    return nameLab;
}

/**
 公用alertConter
 @param title 标题
 @param message 内容
 @param cStyle 样式 UIAlertControllerStyleActionSheet = 底部,UIAlertControllerStyleAlert = 弹窗
 */
+(void)pAlertCWithTitle:(NSString*)title
                message:(NSString*)message
                  style:(UIAlertControllerStyle)cStyle
                   curC:(UIViewController*)curVC
{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:cStyle];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *canceAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:sureAction];
    [alertC addAction:canceAction];
}
+(void)stackView
{
    UIStackView * stackview = [[UIStackView alloc]initWithArrangedSubviews:@[
        [[UIView alloc]init],
    ]];
    
}

/**自动*/
+(MBProgressHUD *)customizeShowLoading:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    //下面的2行代码必须要写，如果不写就会导致指示器的背景永远都会有一层透明度为0.5的背景
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.f];
//    hud.userInteractionEnabled = NO;
    
//    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"naiping_loadAn" withExtension:@"gif"];
//    FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:imgUrl]];
//    GifView * animatedImgView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, ksW(120), ksW(120))];
//    animatedImgView.animatedImage = animatedImg;
//
//    hud.customView = animatedImgView;
    
    hud.animationType = MBProgressHUDAnimationFade;
  
    return hud;
}


+(UIButton*)CustButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

+(UITextField*)loadtextFeild:(NSString*)placeholder
                        font:(UIFont*)font
                   textColor:(UIColor*)color
{
    WCPBaseTextField *textfeild = [[WCPBaseTextField alloc]init];
    textfeild.placeholder = placeholder;
    textfeild.font = font;
    textfeild.textColor = color;
    return textfeild;
}
+(UIImageView*)loadImgViewRadius:(float)radius
                           model:(UIViewContentMode)model
                         backCor:(UIColor*)cor
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
    return ImgV;
}


///-(void)selectClickLab
//{
////#import "YYText.h"
//    NSDictionary *attributes = @{NSFontAttributeName:PFReFONT(25), NSForegroundColorAttributeName:RGBColor(136, 136, 136)};
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"  我已阅读并同意《月子说账号注销须知》<哈哈>" attributes:attributes];
//    //设置高亮色和点击事件
////    kWeakSelf(self);
//    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《月子说账号注销须知》"] color:RGBColor(255, 104, 105) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
////        NSLog(@"点击了《用户协议》");
////        WCPNotesRegistrationViewController *vc = [[WCPNotesRegistrationViewController alloc]init];
////        [weakself.navigationController pushViewController:vc animated:YES];
//    }];
//
//    YYLabel *yyLab = [[YYLabel alloc]init];
//    yyLab.attributedText = text;
//    //居中显示一定要放在这里，放在viewDidLoad不起作用
//    yyLab.textAlignment = NSTextAlignmentCenter;
//}

//富文本添加图片
//NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//attch.image = [UIImage imageNamed:@"pre_right"];
//attch.bounds = CGRectMake(5,0,5.71,10);
//NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//[noteStr appendAttributedString:string];
//[_chongzhi setAttributedText:noteStr];
@end
