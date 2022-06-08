//
//  basicTextField.m
//  hecheng
//
//  Created by 何小弟 on 2017/9/22.
//  Copyright © 2017年 baqianyi. All rights reserved.
//

#import "basicTextField.h"

@implementation basicTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    if (_Imageleft!=0) {
        iconRect.origin.x += _Imageleft;
    }else{
        iconRect.origin.x += 10;
    }
    
    return iconRect;
}

//  重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 1;
    return placeholderRect;
}

//  重写文字输入时的X值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    if (_textleft!=0) {
        editingRect.origin.x +=_textleft;
    }else{
        editingRect.origin.x +=10;
    }

    return editingRect;
}

//  重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    if (_textleft!=0) {
        textRect.origin.x += _textleft;
    }else{
        textRect.origin.x += 10;
    }
    
    return textRect;
}

//  重写占位符的X值
//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
//    placeholderRect.origin.x += 80;
//    return placeholderRect;
//}

////文本框 显示 时的 位置 及 显示范围
//- (CGRect)textRectForBounds:(CGRect)bounds
//{
//    //    return CGRectInset(bounds, -10, 0);
//    CGRect rect = [super textRectForBounds:bounds];
//    return CGRectMake(30, rect.origin.y, rect.size.width + 100 , rect.size.height);
//}
////文本框 编辑 时的 位置 及 显示范围
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    CGRect rect = [super editingRectForBounds:bounds];
//    return CGRectMake(30, rect.origin.y, rect.size.width + 100 , rect.size.height);
//}
////文本框 清除按钮 的 位置 及 显示范围
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    CGRect rect = [super clearButtonRectForBounds:bounds];
//    return CGRectOffset(rect, -50, 0);
//}
////文本框 左视图 的 位置 及 显示范围
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect rect = [super leftViewRectForBounds:bounds];
//    return CGRectOffset(rect, [UIScreen mainScreen].bounds.size.width - 50, 0);
//}


@end
