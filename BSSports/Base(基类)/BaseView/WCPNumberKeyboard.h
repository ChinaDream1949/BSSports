//
//  WCPNumberKeyboard.h
//  CargoSteward
//
//  Created by __ on 2021/4/8.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIFeedbackGenerator.h>


NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    numberHaveDort = 0,     //有点号
    numberNoneDort = 1,     //没有点号
    
} UIKeyBoardStyle;

@interface WCPNumberKeyboard : UIView

@property (copy, nonatomic, nullable) void (^done)(void);  //点击确定执行的回调
@property (nonatomic) UIColor *tintColor;   //主色调（针对确定按钮）

- (instancetype)initWithTintColor:(UIColor *)tintColor;

@property UIKeyBoardStyle style;



@end

NS_ASSUME_NONNULL_END
