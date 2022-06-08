//
//  WCPEmojiKeyboard.h
//  baseXCode
//
//  Created by 华尚 on 2021/6/3.
//

#import <UIKit/UIKit.h>


#define FACE_NAME_HEAD  @"/s"

// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5

NS_ASSUME_NONNULL_BEGIN


@protocol WCPEmojiKeyboardDelegate <NSObject>

@optional
//具体实现可参照最下面
/**选择表情*/
- (void)didTouchEmoj:(NSString *)emojString;
/**删除表情*/
- (void)didTouchBackEmoj;
/**发送按钮*/
- (void)didTouchSendEmoj;

- (void)didSelectedSticker:(NSString *)stickerPath;

@end

@interface WFCUStickerItem : NSObject
@property(nonatomic, strong)NSString *key;
@property(nonatomic, strong)NSString *tabIcon;
@property(nonatomic, strong)NSMutableArray<NSString *> *stickerPaths;
@end

@interface WCPEmojiKeyboard : UIView<UIScrollViewDelegate>
//+ (NSString *)getStickerCachePath;
//+ (NSString *)getStickerBundleName;

@property (nonatomic, weak) id<WCPEmojiKeyboardDelegate> delegate;

@property (nonatomic, assign) BOOL disableSticker;

@end

/**代理实现添加删除表情定位*/
//- (void)didTouchEmoj:(NSString *)emojString {
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:emojString];
//    UIFont *font = [UIFont fontWithName:@"Heiti SC-Bold" size:16];
//    [attStr addAttribute:(__bridge NSString*)kCTFontAttributeName value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
//                                                                                                                   16,
//                                                                                                                   NULL)) range:NSMakeRange(0, emojString.length)];
//
//    UITextPosition* beginning = self.keyField.beginningOfDocument;
//    UITextRange* selectedRange = self.keyField.selectedTextRange;
//    UITextPosition* selectionStart = selectedRange.start;
//    UITextPosition* selectionEnd = selectedRange.end;
//
//    const NSInteger location = [self.keyField offsetFromPosition:beginning toPosition:selectionStart];
//    const NSInteger length = [self.keyField offsetFromPosition:selectionStart toPosition:selectionEnd];
//
//   NSRange range = NSMakeRange(location, length);
//
//    //追加文字
//    // 获得光标所在的位置
//    // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
//    NSString *content = self.keyField.text;
//    NSString *result = [NSString stringWithFormat:@"%@%@%@",[content substringToIndex:location],emojString,[content substringFromIndex:location]];
//    // 将调整后的字符串添加到UITextView上面
//    self.keyField.text = result;
//
//    range = NSMakeRange(location+emojString.length, length);
//    //重新设置位置
//    UITextPosition* endbeginning = self.keyField.beginningOfDocument;
//
//    UITextPosition* startPosition = [self.keyField positionFromPosition:endbeginning offset:range.location];
//    UITextPosition* endPosition = [self.keyField positionFromPosition:endbeginning offset:range.location + range.length];
//    UITextRange* selectionRange = [self.keyField textRangeFromPosition:startPosition toPosition:endPosition];
//
//    [self.keyField setSelectedTextRange:selectionRange];
//}
//
//- (void)didTouchBackEmoj {
//    [self.keyField deleteBackward];
//}

NS_ASSUME_NONNULL_END
