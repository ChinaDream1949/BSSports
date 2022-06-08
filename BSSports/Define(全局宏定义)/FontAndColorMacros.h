//
//  FontAndColorMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.


//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define rgba(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]
#define RGB51  RGBColor(51, 51, 51)
#define RGB250  RGBColor(250, 250, 250)
//按钮渐变色
#define  BtnLeftColor  RGBColor(20, 219, 225)
#define  BtnRightColor  RGBColor(7, 200, 229)
//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]

//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]

#pragma mark -  字体区


#define FFont1 [UIFont systemFontOfSize:12.0f]

#define ksW(width) ((width/375.0) * KScreenWidth)


// 苹方-简 常规体
#define PFReFONT(frontSize) [UIFont fontWithName:@"PingFangSC-Regular"  size:frontSize]
#define PFBoFONT(frontSize) [UIFont fontWithName:@"PingFangSC-Semibold"  size:frontSize]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define QQNSLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#define typesb @"1"
#else
#define QQNSLog(...)
#define typesb @"0"
#endif

#import "UIColor+HZXColor.h"
///适配暗黑模式   lightColor：白天模式颜色  darkColor：暗黑模式颜色
#define RGBDarkColor(lightColor, darkColor) [UIColor colorWithLightColor:lightColor DarkColor:darkColor]
#define HEXDarkColor(lightColor, darkColor) [UIColor colorWithLightColorStr:lightColor DarkColor:darkColor]

#define DarkCor515151 RGBDarkColor(rgba(51, 51, 51, 1), rgba(222, 224, 229, 1))
#define DarkCor153153153 RGBDarkColor(rgba(153, 153, 153, 1), rgba(147, 147, 147, 1))
#define DarkCorWhithe RGBDarkColor(UIColor.whiteColor, rgba(50, 51, 51, 1))


#endif /* FontAndColorMacros_h */
