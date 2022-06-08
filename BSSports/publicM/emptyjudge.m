//
//  emptyjudge.m
//  xiaodizhuanche
//
//  Created by 8000yiMac1 on 2018/4/23.
//  Copyright © 2018年 8000yiMac1. All rights reserved.
//

#import "emptyjudge.h"
#import <sys/utsname.h>
//#import "NSString+Hash.h"
#import <UserNotifications/UserNotifications.h>

@interface emptyjudge ()

@end

@implementation emptyjudge
-(instancetype) init
{
    if (self = [super init]) {
        
    }
    return self;
}
+(void)ObjectVlaue:(id)ObjectVlaue newstrsBlocks:(newstrsBlock)newstrsBlocks
{
    // NSMutableDictionary * Objectparameters = [NSMutableDictionary dictionary];
    NSString * ObjectVlaueNew=@"";
    if ([emptyjudge Values:ObjectVlaue]){
        ObjectVlaueNew=ObjectVlaue;
    }
    return newstrsBlocks(ObjectVlaueNew);
    //[self.Objectparameters setObject:ObjectVlaueNew forKey:Key];
}


//
+(id)processDictionaryIsNSNull:(id)obj
{
    const NSString * blank = @"";
    if ([obj isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        
        for(NSString *key in [dt allKeys])
        {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]])
            {
                [dt setObject:blank forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]])
            {
                NSString *strobj = (NSString*)object;
                if (strobj == nil || [strobj isEqual:[NSNull null]] || strobj == NULL || [strobj isEqual:@"(null)"] || [strobj isEqual:@"<null>"] || [strobj isEqual:@""])
                {
                    [dt setObject:blank forKey:key];
                }
                
            }
            else if ([object isKindOfClass:[NSArray class]])
            {
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
            
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]])
    {
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++)
        {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else
    {
        return obj;
    }
    
}
//判断空对象或空数组 新的
+(BOOL)NewobjValues:(id)obj
{
    if ([obj isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary * dt = [(NSMutableDictionary*)obj mutableCopy];
        if (![emptyjudge Values:dt]) {
            return NO;
        }
    }
    //    else if ([obj isKindOfClass:[NSArray class]])
    //    {
    ////        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
    ////        if (da.count==0) {
    ////            return NO;
    ////        }
    //        return NO;
    //    }
    //    else if ([obj isKindOfClass:[NSString class]])
    //    {
    //        //        NSString * strs = [(NSString*)obj mutableCopy];
    //        //        if (![emptyjudge Values:strs]) {
    //        //            return NO;
    //        //        }
    //        return NO;
    //    }
    //    else if ([obj isKindOfClass:[NSNumber class]])
    //    {
    //        return NO;
    //        //        NSNumber * strs = [(NSNumber*)obj mutableCopy];
    //        //        if (strs == 0) {
    //        //            return NO;
    //        //        }
    //    }
    else
    {
        return NO;
    }
    return YES;
    
}
//判断空对象或空数组
+(BOOL)objValues:(id)obj
{
    if ([obj isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary * dt = [(NSMutableDictionary*)obj mutableCopy];
        if (![emptyjudge Values:dt]) {
            return NO;
        }
    }
    else if ([obj isKindOfClass:[NSArray class]])
    {
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        if (da.count==0) {
            return NO;
        }
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        NSString * strs = [(NSString*)obj mutableCopy];
        if (![emptyjudge Values:strs]) {
            return NO;
        }
    }
    
    return YES;
    
}
+(BOOL)Values:(id)Values
{
    if (Values == nil || [Values isEqual:[NSNull null]] || Values == NULL || [Values isEqual:@"(null)"] || [Values isEqual:@"<null>"] || [Values isEqual:@""])
    {
        return NO;
    }
    return YES;
}
+(BOOL)isValidateMobile:(NSString *)mobile
{
    if (mobile.length == 11)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)islengthstr:(NSString *)passstr
{
    if (passstr.length < 6)
    {
        return NO;
    }
    else if (passstr.length > 20)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

//获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeTimestampnew
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//将yyyymmdd字符串格式转换为nstimeinterval
+(NSInteger)withDateFormat:(NSString *)format
{
    
    NSString *string = [NSString stringWithFormat:@"%@",format];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//dd/MM/yyyy hh:mm  yyyy-MM-dd 5484245515642
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:string];
    NSLog(@"dateFromString = %@", date);
    //date to timestamp
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSLog(@"timeInterval = %f", timeInterval);//1495209600.000000
    
    return timeInterval;
    
}
//
/**
 获取当地当前时间
 @return 时间字符串
 */
+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // yyyy-MM-dd 可自定义，也可以换成 yyyy-MM-dd HH:MM:SS
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
    
}
/**
 将字符串转成NSDate类型
 @param dateString 时间类型的字符串 例如：2018-07-12
 @return date
 */
+ (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *inputDate = [inputFormatter dateFromString:dateString];
    
    //inputDate或出现相差八小时问题，下面是解决相差八小时
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: inputDate];
    
    NSDate *localeDate = [inputDate  dateByAddingTimeInterval: interval];
    
    return localeDate;
    
}
/**
 传入今天的时间，返回明天的时间
 @param aDate 当前的时间NSDate类型，上面的方法可获取当前时间的NSDate类型
 @return 明天时间
 */
+ (NSString *)getTomorrowDay:(NSDate *)aDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday |NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    
    [dateday setDateFormat:@"yyyy-MM-dd"];
    
    return [dateday stringFromDate:beginningOfWeek];
    
}
/**
 判断是否为今天
 @param todayTime 时间（NSDate）
 @return YES，是 NO ～
 */
+ (BOOL)isTodayWithTime:(NSDate*)todayTime{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:todayTime];
    
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate]){
        return YES;
    }
    return NO;
}
/**
 获取当前时间戳
 *1000 是精确到毫秒，不乘就是精确到秒
 @return 返回时间戳
 */
+ (NSString *)currentTimeStr{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
    
}
/**
 
 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
 传入的时间戳str如果是精确到毫秒的记得要/1000
 @param timeStr 时间戳
 @return 返回时间
 */
+ (NSString *)getDateStringWithTimeStr:(NSString *)timeStr{
    
    NSTimeInterval time=[timeStr doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    //     NSTimeInterval time=[timeStr doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    
    return currentDateStr;
    
}
/**
 时间戳转化为字符串
 
 @param timestamp 时间戳
 @return 时间字符串
 */
+ (NSString *)convertTimeStampsToString:(NSString *)timestamp{
    
    NSTimeInterval time=[timestamp doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:time];
    return [stampFormatter stringFromDate:stampDate];
}
/**
 字符串转时间戳 如：2017-4-10 17:15:10
 @param time 时间
 @return 时间戳
 */
+ (NSString *)getTimeStrWithString:(NSString *)time{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    
    NSDate *tempDate = [dateFormatter dateFromString:time];//将字符串转换为时间对象
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    
    return timeStr;
    
}
//获取当前的时间
+(NSString*)getCurrentTimes
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);return currentTimeString;
    
}

/**
 获取当前是星期几
 @return 1、2、3、4、5、6、7(星期六是 7 ，星期日 1)
 */
+ (NSInteger)getNowWeekday{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate *now = [NSDate date];
    
    // 在真机上需要设置区域，才能正确获取本地日期，中国区代码：zh_CN
    
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    comps = [calendar components:unitFlags fromDate:now];
    
    return [comps weekday];
    
}
/**
 获取当前是几月几日
 @return 07月07日
 */
+ (NSString *)getTodayStr{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日";
    return [formatter stringFromDate:today];
    
}
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}

// 比较两个日期的大小
+(NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    //    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //相等
        aa = 0;
    }else if (result==NSOrderedAscending) {
        //bDate比aDate大
        aa = 1;
    }else if (result==NSOrderedDescending) {
        //bDate比aDate小
        aa = -1;
    }
    return aa;
}
#pragma mark - ***** 验证输入的是否 1到99之间的整数
+(BOOL)ba_isAllNumber:(NSString *)allNumberStr
{
    NSString *pattern = @"^(1|([1-9]\\d{0,1})|99)$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:allNumberStr options:0 range:NSMakeRange(0, allNumberStr.length)];
    return results.count > 0;
}
#pragma mark - 判断字符串中是否包含数字
+(BOOL)isStringContainNumberWith:(NSString *)str
{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0)
    {
        return YES;
        
    }
    return NO;
    
}
#pragma mark - 判断字符串中是否包含英文字母
+(BOOL)isStringContainletterWith:(NSString *)str
{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    if (count > 0)
    {
        return YES;
        
    }
    return NO;
    
}
#pragma mark - 判断字符串中是否包含数字和字母
+(BOOL)isStringContainNumberAndletterWith:(NSString *)str
{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"A-Za-z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0)
    {
        return YES;
        
    }
    return NO;
    
}
//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
// iOS 截取字符串中两个指定字符串中间的字符串方法 方法封装
+(NSString *)wholestr:(NSString*)wholestr subStringFrom:(NSString *)startString to:(NSString *)endString
{
    NSRange startRange = [wholestr rangeOfString:startString];
    NSRange endRange = [wholestr rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString * result = [wholestr substringWithRange:range];
    return result;
    
    // 为了使用方便,我们可以给 NSString 分类添加一个截取字符创的方法,直接返回截取后的字符串:代码如下
    //    // NSString 分类中实现如下方法:
    //#import "NSString+Extension_NSString.h"
    //    @implementation NSString (Extension_NSString)
    //    // 截取字符串方法封装
    //    // 截取字符串方法封装
    //    - (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    //        NSRange startRange = [self rangeOfString:startString];
    //        NSRange endRange = [self rangeOfString:endString];
    //        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    //        return [self substringWithRange:range];
    //    }
    //    @end
    //    // 控制器中直接用字符串调用:
    //#import "ViewController.h"
    //#import "NSString+Extension_NSString.h"
    //    @interface ViewController ()
    //    @end
    //    @implementation ViewController
    //    - (void)viewDidLoad {
    //        [super viewDidLoad];
    //        NSString *string = @"<a href=\"http\">这是要截取的内容</a>";
    //        NSString *result = [string subStringFrom:@"\">" to:@"</"];
    //        NSLog(@"%@",result);
    //    }
    //    // 这样使用起来更方便,简洁
    
}
//1、首先上判断字符串是否含有表情符号的代码
/**
  *  判断字符串中是否存在emoji
  * @param string 字符串
  * @return YES(含有表情)
  */
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f)
                {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3)
            {
                returnValue = YES;
            }
        }
        else
        {
            if (0x2100 <= hs && hs <= 0x27ff)
            {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07)
            {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935)
            {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299){
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
            {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
    
}
/**
  *  判断字符串中是否存在emoji
  * @param string 字符串
  * @return YES(含有表情)
  */
+ (BOOL)hasEmoji:(NSString*)string;
{
    
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
}
//2、然后是去除字符串中的表情
//去除字符串中所带的表情
+ (NSString *)disable_emoji:(NSString *)text
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    
    return modifiedString;
}
//3、由于苹果系统自带的九宫格输入汉字的过程中也会默认是表情符号，因此需要添加判断当前是否是九宫格键盘
/**
  判断是不是九宫格
  @param string 输入的字符
  @return YES(是九宫格拼音键盘)
  */
+(BOOL)isNineKeyBoard:(NSString *)string
{
    
    NSString *other = @"➋➌➍➎➏➐➑➒";
    
    int len = (int)string.length;
    
    for(int i=0;i<len;i++)
        
    {
        
        if(!([other rangeOfString:string].location != NSNotFound))
            
            return NO;
        
    }
    
    return YES;
}
/*!
 109  *  正则匹配
 110  *
 111  *  @param str     匹配的字符串
 112  *  @param pattern 匹配规则
 113  *
 114  *  @return 返回匹配结果
 115  */
+ (BOOL)matchString:(NSString *)str withPattern:(NSString *)pattern resultBlock:(resultBlock)block {
    NSError *error = nil;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern: pattern options: NSRegularExpressionCaseInsensitive error: &error];
    if (!error) {
        NSTextCheckingResult *result = [regular firstMatchInString:str options:0 range:NSMakeRange(0, str.length)];
        if (result) {
            NSLog(@"匹配成功");
            block([str substringWithRange:result.range]);
            return YES;
        } else {
            NSLog(@"匹配失败");
            return NO;
        }
    }
    NSLog(@"匹配失败,Error: %@",error);
    return NO;
}
/**
 *  @author zhengju, 16-06-29 10:06:05
 *
 *  @brief 检测字符串中是否含有中文，备注：中文代码范围0x4E00~0x9FA5，
 *
 *  @param string 传入检测到中文字符串
 *
 *  @return 是否含有中文，YES：有中文；NO：没有中文
 */
+ (BOOL)checkIsChinese:(NSString *)string{
    for (int i=0; i<string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}
//是否全是中文
+ (BOOL)regularChinese:(NSString*)regularstr {
    NSString *regexStr = @"[\u4e00-\u9fa5]+";
    NSPredicate *predStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    if (![predStr evaluateWithObject:regularstr]) {
        return NO;
    }else {
        return YES;
    }
}
//是否全是数字
+(BOOL)regularNumber:(NSString*)regularstr {
    NSString *regexNumber = @"[0-9]*";
    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexNumber];
    if (![predNumber evaluateWithObject:regularstr]) {
        return NO;
    }else {
        return YES;
    }
}
/** 密码 8-16位数字、字母、符号至少两种组合 */
+(BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
/** 去除掉首尾的空白字符和换行字符 */
+(NSString*)textstr:(NSString*)strtext
{
    NSLog(@"输入=%@",strtext);
    NSString * textViewstr=[NSString stringWithFormat:@"%@",strtext];
    textViewstr = [textViewstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    textViewstr = [textViewstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    textViewstr = [textViewstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    textViewstr = [textViewstr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSLog(@"输入textViewstr=%@",textViewstr);
    return textViewstr;
}
/** 银行卡号密文形式展示 让银行卡明文字符显示变成前4位和后4位是明文，中间4位是*的字符 */
+(NSString *)getNewStarBankNumWitOldNum:(NSString*)strtext
{
    NSString *bankNum = strtext;
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>3&&i<mutableStr.length - 4) {
                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
}
//+(NSString *)returnBankCard:(NSString *)BankCardStr
//{
//    NSString *formerStr = [BankCardStr substringToIndex:4];
//    NSString *str1 = [BankCardStr stringByReplacingOccurrencesOfString:formerStr withString:@""];
//    NSString *endStr = [BankCardStr substringFromIndex:BankCardStr.length-4];
//    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:endStr withString:@""];
//    NSString *middleStr = [str2 stringByReplacingOccurrencesOfString:str2 withString:@"****"];
//    NSString *CardNumberStr = [formerStr stringByAppendingFormat:@"%@%@",middleStr,endStr];
//    return CardNumberStr;
//}
/** 身份证验证 */
+(BOOL)validateIDCardNumber:(NSString *)value {
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [value substringWithRange:NSMakeRange(17,1)];
                
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                    
                }
                
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

#pragma mark - *****正则判断元素是否是数字
+(BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0)
        return NO;
    NSString *regex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}
#pragma mark - ***** 判断至多两位小数的正则表达式
//首先是整数部分： [0-9] 意思是0到9任意一个数字都匹配   + 代表可是是一个或者多个  因此整数部分是：  [0-9]+
//接下来是小数部分 ：  首先要表示小数点  \\. (因为小数点是特殊符号，所以前面需要加一个\来转义) ；     [0-9]{1,2} 代表可以是1或者2位数字   因此小数部分是：\\.[0-9]{1,2}
+(BOOL)validateMoney:(NSString *)money
{
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}
+ (NSString *)appVersion {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}
+ (NSString *)device {
    return @"IOS";
}

//手机品牌
+(NSString*)phoneBrand
{
    return @"iphone";
}
+(NSString*)os_type
{
    return @"2";
}

+(NSString*)ObjectVlaue:(id)ObjectVlaue
{
    
    NSString * ObjectVlaueNew=@"";
    if ([emptyjudge Values:ObjectVlaue]){
        ObjectVlaueNew=ObjectVlaue;
    }
    return ObjectVlaueNew;
    
}
/**
 根据高度度求宽度
 
 @param text 计算的内容
 @param height 计算的高度
 @param font 字体大小
 @return 返回宽度
 */
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font
{
    //加上判断，防止传nil等不符合的值，导致程序奔溃
    if (text == nil || [text isEqualToString:@""]){
        text = @"无";
    }
    if (font <= 0){
        font = 13;
    }
    if (height < 0){
        height = 0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
+(NSString *)generateTradeNO
{
    static int kNumber = 32;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
    
}
+(NSString *)Tockenstr
{
    NSString  * allstr =[NSString stringWithFormat:@"%@",[self generateTradeNO]];
    NSLog(@"===%@",allstr);
    return allstr;
}

#pragma mark - 是否开启APP推送
/**是否开启推送*/
+ (BOOL)isSwitchAppNotification
{
    if ([[UIDevice currentDevice].systemVersion floatValue]  >= 10.0)
    {
        __block BOOL result = NO;
        //异步线程中操作是否完成
        __block BOOL inThreadOperationComplete = NO;
        if (@available(iOS 10.0, *))
        {
            [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                    result = NO;
                }else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                    result = NO;
                }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                    result = YES;
                }else {
                    result = NO;
                }
                inThreadOperationComplete = YES;
            }];
        }
        else
        {
            // Fallback on earlier versions
        }
        
        while (!inThreadOperationComplete) {
            [NSThread sleepForTimeInterval:0];
        }
        return result;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    else if ([[UIDevice currentDevice].systemVersion floatValue]  >= 8.0)
    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }else {
            return NO;
        }
        
    }
    else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type) {
            return YES;
        }else {
            return NO;
        }
    }
#pragma clang diagnostic pop
}
+(CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
+(float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width{
    
    if (str == nil || width <= 0) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.height);
    
}

// 传一个字符串和字体大小来返回一个字符串所占的宽度

+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont{
    
    if (str == nil) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.width);
    
}



+(CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont

{
    
    if (str == nil) return CGSizeZero;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return measureSize;
    
}

#pragma mark - 判断是不是首次登录或者版本更新
+ (BOOL) isFirstLaunch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    //    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    NSString * version=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"kAppVersion"]];
    //版本升级或首次登录
    if ([emptyjudge isBlankString:version] || ![version isEqualToString:currentAppVersion]) {
        return YES;
    }else{
        return NO;
    }
}
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] ==0) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isEmail:(NSString*)email {
    NSString *reg =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:email];
}

+ (BOOL)isValidPassword:(NSString *)password {
    NSString *reg =@"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:password];
}

+(NSString*)curTimestamp
{
    return [NSString stringWithFormat:@"%lld", [NSNumber numberWithDouble:NSDate.date.timeIntervalSince1970].longLongValue];
}

//判断是否是手机号码
+ (BOOL) IsValiddateMobile:(NSString*)pstrMobile
{
//    手机号以13.15.17。18开头
    NSString* pPhoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate* pPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pPhoneRegex];
    return [pPhoneTest evaluateWithObject:pstrMobile];
}
+(BOOL)responseDataVerification:(id)response
{
    if ([response objectForKey:_data_] &&
        [[response objectForKey:_data_] isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    return NO;
}
//获取当前最上层的控制器
+ (UIViewController *)getTopMostController {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //循环之前tempVC和topVC是一样的
    UIViewController *tempVC = topVC;
    while (1) {
        if ([topVC isKindOfClass:[UITabBarController class]]) {
            topVC = ((UITabBarController*)topVC).selectedViewController;
        }
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            topVC = ((UINavigationController*)topVC).visibleViewController;
        }
        if (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        //如果两者一样，说明循环结束了
        if ([tempVC isEqual:topVC]) {
            break;
        } else {
        //如果两者不一样，继续循环
            tempVC = topVC;
        }
    }
    return topVC;
}
#define groupAvatarWidth (48*[[UIScreen mainScreen] scale])
#define DefaultAvatarImage [UIImage imageNamed:@""]
/**用图片链接数组 拼凑群组聊天九宫格头像
 @param group 图片链接数组
 */
+ (void)createGroupAvatar:(NSArray *)group finished:(void (^)(UIImage *groupAvatar))finished
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger avatarCount = group.count > 9 ? 9 : group.count;
        CGFloat width = groupAvatarWidth / 3 * 0.90;
        CGFloat space3 = (groupAvatarWidth - width * 3) / 4;                      // 三张图时的边距（图与图之间的边距）
        CGFloat space2 = (groupAvatarWidth - width * 2 + space3) / 2;             // 两张图时的边距
        CGFloat space1 = (groupAvatarWidth - width) / 2;                          // 一张图时的边距
        __block CGFloat y = avatarCount > 6 ? space3 : (avatarCount > 3 ? space2 : space1);
        __block CGFloat x = avatarCount  % 3 == 0 ? space3 : (avatarCount % 3 == 2 ? space2 : space1);
        width = avatarCount > 4 ? width : (avatarCount > 1 ? (groupAvatarWidth - 3 * space3) / 2 : groupAvatarWidth );  // 重新计算width；
        
        if (avatarCount == 1) {                                          // 1,2,3,4 张图不同
            x = 0;
            y = 0;
        }
        if (avatarCount == 2) {
            x = space3;
        } else if (avatarCount == 3) {
            x = (groupAvatarWidth -width)/2;
            y = space3;
        } else if (avatarCount == 4) {
            x = space3;
            y = space3;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, groupAvatarWidth, groupAvatarWidth)];
            [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
            view.layer.cornerRadius = 6;
            __block NSInteger count = 0;               //下载图片完成的计数
            for (NSInteger i = avatarCount - 1; i >= 0; i--) {
                NSString *avatarUrl = [group objectAtIndex:i];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
                [view addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:DefaultAvatarImage completed:^(UIImage * _Nullable image,
                                                                                                                              NSError * _Nullable error,
                                                                                                                              SDImageCacheType cacheType,
                                                                                                                              NSURL * _Nullable imageURL) {
                    count ++ ;
                    if (count == avatarCount) {     //图片全部下载完成
                        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 2.0);
                        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
                        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndPDFContext();
                        CGImageRef imageRef = image.CGImage;
                        CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, view.frame.size.width*2, view.frame.size.height*2));
                        UIImage *ansImage = [[UIImage alloc] initWithCGImage:imageRefRect];
                        CGImageRelease(imageRefRect);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (finished) {
                                finished(ansImage);
                            }
                        });
                    }
                    
                }];
                
                if (avatarCount == 3) {
                    if (i == 2) {
                        y = width + space3*2;
                        x = space3;
                    } else {
                        x += width + space3;
                    }
                } else if (avatarCount == 4) {
                    if (i % 2 == 0) {
                        y += width +space3;
                        x = space3;
                    } else {
                        x += width +space3;
                    }
                } else {
                    if (i % 3 == 0 ) {
                        y += (width + space3);
                        x = space3;
                    } else {
                        x += (width + space3);
                    }
                }
            }
        });
        
    });
    
}
@end 
