//
//  WCPBaseTextField.m
//  ToAskLive
//
//  Created by __ on 2021/1/15.
//

#import "WCPBaseTextField.h"

@implementation WCPBaseTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
// 重写此方法
-(void)drawPlaceholderInRect:(CGRect)rect
{
 // 计算占位文字的 size
    CGSize placeholdersize = [self.placeholder sizeWithAttributes:
                              @{NSFontAttributeName : self.font}];
    CGRect r = CGRectMake(0, (rect.size.height - placeholdersize.height)/2, rect.size.width, rect.size.height);
    
    UIColor *cor = UIColor.darkGrayColor;
    if (@available(iOS 13.0, *)) {
        cor = [UIColor placeholderTextColor];
    }
    [self.placeholder drawInRect:r
                  withAttributes:
     @{NSForegroundColorAttributeName : (self.cPlaceholderTextColor? self.cPlaceholderTextColor : cor),
       NSFontAttributeName : self.font}];
}


//限制text输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if(self.textNumb == 0)
    {
        return;
    }
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _textNumb)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:_textNumb];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:_textNumb];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, _textNumb)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
//                [MBProgressHUD showMessageText:@"标题最多20个字" toView:self afterDelay:NSTimeIntervaltext];
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > _textNumb)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:_textNumb];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:_textNumb];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,_textNumb)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
            
//            [MBProgressHUD showMessageText:@"标题最多20个字" toView:self afterDelay:NSTimeIntervaltext];
        }
    }
//    if (textField.text.length == 0) {
//        textField.text = self.nameStr;
//    }

}

- (void)setKeyBType:(CPTextFieldType)type
{
    if (type == 1) {
        self.keyboardType = UIKeyboardTypeDefault;
    }else if(type == 2){
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (type == 3){
        self.keyboardType = UIKeyboardTypeASCIICapable;
    }
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
}
@end
