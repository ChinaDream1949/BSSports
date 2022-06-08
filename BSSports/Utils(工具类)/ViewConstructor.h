//
//  ViewConstructor.h
//  yunbaolive
//
//  Created by __ on 2020/12/15.
//  Copyright © 2020 cat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCPBaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewConstructor : NSObject

/**
 生成一个uilabel
 */
+(UILabel*)LableInitTitle:(NSString*)title
                 font:(UIFont*)font
            textColor:(UIColor*)textColor
                alignment:(NSTextAlignment)aligment;

/**gif记载动画*/
//+(MBProgressHUD *)customizeShowLoading:(UIView *)view;
/**通用button*/
+(UIButton*)CustButton;
/**通用textfeild*/
+(WCPBaseTextField*)loadtextFeild:(NSString*)placeholder
                        font:(UIFont*)font
                   textColor:(UIColor*)color;
//构建imageview
+(UIImageView*)loadImgViewRadius:(float)radius
                           model:(UIViewContentMode )model
                         backCor:(UIColor* __nullable)cor;

@end

NS_ASSUME_NONNULL_END
