//
//  WCPBaseTextField.h
//  ToAskLive
//
//  Created by __ on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TFDefault, //通用输入
    TFDecimalPad,//数字带点
    TFASCIICapable,//英文+数字输入
} CPTextFieldType;

@interface WCPBaseTextField : UITextField
/**自定义placeholder颜色*/
@property (nonatomic,strong)UIColor *cPlaceholderTextColor;
/**字数限制*/
@property (nonatomic,assign)int textNumb;
- (void)textFieldDidChange:(UITextField *)textField;

- (void)setKeyBType:(CPTextFieldType)type;
@end

NS_ASSUME_NONNULL_END
