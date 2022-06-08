//
//  basicTextField.h
//  hecheng
//
//  Created by 何小弟 on 2017/9/22.
//  Copyright © 2017年 baqianyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface basicTextField : UITextField
//- (CGRect)borderRectForBounds:(CGRect)bounds;
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)placeholderRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds;
- (CGRect)leftViewRectForBounds:(CGRect)bounds;
//- (CGRect)rightViewRectForBounds:(CGRect)bounds;

@property (assign, nonatomic) CGFloat Imageleft;
@property (assign, nonatomic) CGFloat textleft;


@end
