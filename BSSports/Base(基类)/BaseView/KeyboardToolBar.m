//
//  KeyboardToolBar.m
//  JFTX_WuHanPJJY
//
//  Created by YC on 16/11/29.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "KeyboardToolBar.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define toolBarColor [UIColor colorWithRed:26.0/255.0 green:141.0/255.0 blue:248.0/255.0 alpha:1.0]

@implementation KeyboardToolBar

- (instancetype)initWithShowChangeButton:(BOOL)show {
    self = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0,0, kWidth,35)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 60, 5,50, 25)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:toolBarColor forState:UIControlStateNormal];
    button.layer.borderColor = toolBarColor.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(finishBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    if (show) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 50, 25)];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
        [backBtn setTitleColor:toolBarColor forState:UIControlStateNormal];
        [self addSubview:backBtn];
        [backBtn addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth - 130, 5, 50, 25)];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:toolBarColor forState:UIControlStateNormal];
        [self addSubview:nextBtn];
        [nextBtn addTarget:self action:@selector(nextBtnClick)forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    
    self = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0,0, kWidth,35)];
    _array = array;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 60, 5,50, 25)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:toolBarColor forState:UIControlStateNormal];
    button.layer.borderColor = toolBarColor.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(finishBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    if (array.count >= 2) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 50, 25)];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
        [backBtn setTitleColor:toolBarColor forState:UIControlStateNormal];
        [self addSubview:backBtn];
        [backBtn addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth - 130, 5, 50, 25)];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:toolBarColor  forState:UIControlStateNormal];
        [self addSubview:nextBtn];
        [nextBtn addTarget:self action:@selector(nextBtnClick)forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)finishBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = _array[idx];
        [tf resignFirstResponder];
    }];
}

- (void)backBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = _array[idx];
        if ([tf isFirstResponder] && tf != _array.firstObject) {
            UITextField *nextTf = _array[idx - 1];
            [nextTf becomeFirstResponder];
            *stop = YES;
        } else {
            [tf resignFirstResponder];
        }
    }];
    if (self.backBtnClickBlock) {
        self.backBtnClickBlock();
    }
}

- (void)nextBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = _array[idx];
        if ([tf isFirstResponder] && tf != _array.lastObject) {
            UITextField *nextTf = _array[idx + 1];
            [nextTf becomeFirstResponder];
            *stop = YES;
        } else {
            [tf resignFirstResponder];
        }
    }];
    if (self.nextBtnClickBlock) {
        self.nextBtnClickBlock();
    }
}


@end
