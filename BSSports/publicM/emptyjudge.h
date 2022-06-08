//
//  emptyjudge.h
//  xiaodizhuanche
//
//  Created by 8000yiMac1 on 2018/4/23.
//  Copyright © 2018年 8000yiMac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^resultBlock)(NSString *res);
/**
 请求成功的block
 */
typedef void(^sharingSuccess)(NSMutableDictionary *dic,NSString*Urlstr);
/**
 推送消息参数
 */
typedef void(^Pushmessageparameters)(NSMutableDictionary * dic);
/**
 */
typedef void(^newstrsBlock)(NSString * newstr);

/**
 七鱼参数
 */
//typedef void(^QYMutableArrayBook)(NSMutableArray * QYMutableArray);
/*
 以下Block的参数你根据自己项目中的需求来指定, 这里仅仅是一个演示的例子
 */

/**
 请求成功的block
 
 */
typedef void(^strsRequestSuccess)(NSString *strs,NSInteger type);
/**
 请求成功的block 返回封面地址路径
 type=1成功 2失败
 */
typedef void(^pathSuccess)(NSString * pathstrs,BOOL result);
///**
// 请求失败的block
// 
// @param error 扩展信息
// */
//typedef void(^PPRequestFailure)(NSString *type);

@interface emptyjudge : NSObject


@property (nonatomic, strong) NSMutableDictionary * Objectparameters;
/** 处理字典参数*/
+(void)ObjectVlaue:(id)ObjectVlaue newstrsBlocks:(newstrsBlock)newstrsBlocks;
+(id)processDictionaryIsNSNull:(id)obj;
//判断空对象或空数组
+(BOOL)objValues:(id)obj;
+(BOOL)Values:(id)Values;
+(BOOL)isValidateMobile:(NSString *)mobile;
+(BOOL)islengthstr:(NSString *)passstr;
//获取当前的时间
+(NSString*)getCurrentTimes;
//
+(NSString *)getNowTimeTimestampnew;
+(NSString*)Tockenstr;

+(NSInteger)withDateFormat:(NSString *)format;
/**
 获取当地当前时间
 @return 时间字符串
 */
+ (NSString *)getCurrentTime;
/**
 传入今天的时间，返回明天的时间
 @param aDate 当前的时间NSDate类型，上面的方法可获取当前时间的NSDate类型
 @return 明天时间
 */
+ (NSString *)getTomorrowDay:(NSDate *)aDate;

// iOS 截取字符串中两个指定字符串中间的字符串方法 方法封装
+(NSString *)wholestr:(NSString*)wholestr subStringFrom:(NSString *)startString to:(NSString *)endString;
/**
 
 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
 传入的时间戳str如果是精确到毫秒的记得要/1000
 @param timeStr 时间戳
 @return 返回时间
 */
+ (NSString *)getDateStringWithTimeStr:(NSString *)timeStr;
/**
 字符串转时间戳 如：2017-4-10 17:15:10
 @param time 时间
 @return 时间戳
 */
+ (NSString *)getTimeStrWithString:(NSString *)time;
/**
 讲时间戳转化为字符串
 
 @param timestamp 时间戳
 @return 时间字符串
 */
+ (NSString *)convertTimeStampsToString:(NSString *)timestamp;
/**
 获取当前时间戳
 *1000 是精确到毫秒，不乘就是精确到秒
 @return 返回时间戳
 */
+ (NSString *)currentTimeStr;
/**
  *  判断字符串中是否存在emoji
  * @param string 字符串
  * @return YES(含有表情)
  */
+(BOOL)hasEmoji:(NSString*)string;
/**
  *  判断字符串中是否存在emoji
  * @param string 字符串
  * @return YES(含有表情)
  */
+(BOOL)stringContainsEmoji:(NSString *)string;
//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
/** 判断字符串中是否包含数字 **/
+(BOOL)isStringContainNumberWith:(NSString *)str;
+(NSString *)appVersion;
+(NSString *)device;
/*!
 109  *  正则匹配
 110  *
 111  *  @param str     匹配的字符串
 112  *  @param pattern 匹配规则
 113  *
 114  *  @return 返回匹配结果
 115  */
+ (BOOL)matchString:(NSString *)str withPattern:(NSString *)pattern resultBlock:(resultBlock)block;
//是否全是中文
+ (BOOL)regularChinese:(NSString*)regularstr;
//是否全是数字
+(BOOL)regularNumber:(NSString*)regularstr;
/** 是否含有中文 */
+ (BOOL)checkIsChinese:(NSString *)string;
/** 密码 数字、字母、符号至少两种 */
+(BOOL)checkPassword:(NSString *)password;
/** 去除掉首尾的空白字符和换行字符 */
+(NSString*)textstr:(NSString*)strtext;
/** 身份证判断 */
+(BOOL)validateIDCardNumber:(NSString *)value;
//比较两个日期的大小
//+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;

#pragma mark - *****正则判断元素是否是数字
+(BOOL)inputShouldNumber:(NSString *)inputString;
#pragma mark - ***** 判断至多两位小数的正则表达式
//首先是整数部分： [0-9] 意思是0到9任意一个数字都匹配   + 代表可是是一个或者多个  因此整数部分是：  [0-9]+
//接下来是小数部分 ：  首先要表示小数点  \\. (因为小数点是特殊符号，所以前面需要加一个\来转义) ；     [0-9]{1,2} 代表可以是1或者2位数字   因此小数部分是：\\.[0-9]{1,2}
+(BOOL)validateMoney:(NSString *)money;
/** 银行卡号密文形式展示 */
+(NSString *)getNewStarBankNumWitOldNum:(NSString*)strtext;
#pragma mark - ***** 验证输入的是否 1到99之间的整数
+(BOOL)ba_isAllNumber:(NSString *)allNumberStr;

// 比较两个日期的大小
+(NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
#pragma mark - 手机信息

/**
 手机品牌
 */
+(NSString*)phoneBrand;
/**
 系统 安卓1 ios2
 */
+(NSString*)os_type;

//空值处理
+(NSString*)ObjectVlaue:(id)ObjectVlaue;
/**
 根据高度度求宽度
 
 @param text 计算的内容
 @param height 计算的高度
 @param font 字体大小
 @return 返回宽度
 */
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;
#pragma mark - 是否开启APP推送
/**是否开启推送*/
+ (BOOL)isSwitchAppNotification;
//获取字符串高
+(CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;
//获取字符串宽
+(CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont;
//获取字符串宽 // 传一个字符串和字体大小来返回一个字符串所占的宽度
+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont;
//获取字符串高 // 传一个字符串和字体大小来返回一个字符串所占的高度
+(float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width;

#pragma mark - 判断是不是首次登录或者版本更新
+ (BOOL) isFirstLaunch;
/**8-16的英文数字组合
*/
+ (BOOL)isValidPassword:(NSString *)password ;
//判断是否是手机号码
+ (BOOL) IsValiddateMobile:(NSString*)pstrMobile;
/**当前时间搓*/
+(NSString*)curTimestamp;

/**
 * -------RSA 字符串公钥加密-------
 @param plaintext 明文，待加密的字符串
 @param pubKey 公钥字符串
 @return 密文，加密后的字符串
 */
+ (NSString *)encrypt:(NSString *)plaintext PublicKey:(NSString *)pubKey;

/**验证请求返回值是否正确*/
+(BOOL)responseDataVerification:(id)response;
/**获取当前最上层的控制器*/
+ (UIViewController *)getTopMostController;
/**用图片链接数组 拼凑群组聊天九宫格头像
 @param group 图片链接数组
 */
+ (void)createGroupAvatar:(NSArray *)group finished:(void (^)(UIImage *groupAvatar))finished;
@end

