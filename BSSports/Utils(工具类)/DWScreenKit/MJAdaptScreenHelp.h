//
//  MJAdaptScreenHelp.h
//  Pods
//
//  Created by manjiwang on 2019/4/4.
//

#ifndef MJAdaptScreenHelp_h
#define MJAdaptScreenHelp_h

#define DH_INLINE static inline
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
static const CGFloat mj_originWidth_ = 375.f;//iphone6为基准
static const CGFloat mj_originHeight_ = 667.f;

DH_INLINE BOOL mj_isiPhoneX() {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        // 获取底部安全区域高度，iPhone X 竖屏下为 34.0，横屏下为 21.0，其他类型设备都为 0
        CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;
        if (bottomSafeInset == 34.0f || bottomSafeInset == 21.0f) {
            return YES;
        }
    }
    return NO;
}

DH_INLINE CGFloat mj_bottomSpace() {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        // 获取底部安全区域高度，iPhone X 竖屏下为 34.0，横屏下为 21.0，其他类型设备都为 0
        CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;
        return bottomSafeInset;
    }
    return 0;
}

DH_INLINE CGFloat mj_statusBarHeight() {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    return statusBarFrame.size.height;
}

DH_INLINE CGFloat mj_navigationHeight() {
    if (mj_isiPhoneX()) {
        return 88.00;
    }
    return 64.00;
}

//内联函数
DH_INLINE CGFloat mj_hotizontalRatio() {
    return  [UIScreen mainScreen].bounds.size.width / mj_originWidth_;//水平方向上的比率，value当前屏幕的值，return等比例适配后的值
    
}

DH_INLINE CGFloat mj_verticalRatio() {
    return [UIScreen mainScreen].bounds.size.height / mj_originHeight_;//垂直方向上的比率
}
/**
 *  传一个位置大小得到转换后的center
 *
 *  @param frame 位置大小
 *
 *  @return 返回一个点
 */
DH_INLINE CGPoint mj_centerFromFrame(CGRect frame) {
    return CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
}

/**
 *  传入大小  和 中心
 *
 *  @param size   大小
 *  @param center 中心位置
 *
 *  @return 返回一个位置大小
 */
DH_INLINE CGRect mj_frameWithSizeAndCenter(CGSize size,CGPoint center) {
    return CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
}

DH_INLINE CGPoint mj_flexibleCenter(CGPoint center, BOOL adjustWidth) {//基准屏幕下的center
    if (adjustWidth) {
        CGFloat x = center.x * mj_verticalRatio();
        CGFloat y = center.y * mj_verticalRatio();
        return CGPointMake(x, y);
    }
    CGFloat x = center.x * mj_hotizontalRatio();
    CGFloat y = center.y * mj_verticalRatio();
    return CGPointMake(x, y);//返回一个适配后的center
}

/**
 *  等比例适配size（iphone 4）
 *
 *  @param size        基准屏幕下的size
 *  @param adjustWidth 如果是yes,则返回size的宽高同时乘以高的比率
 *
 *  @return 适配后的size
 */
DH_INLINE CGSize mj_flexibleSize(CGSize size,BOOL adjustWidth) {
    if (adjustWidth) {
        return CGSizeMake(size.width * mj_verticalRatio(), size.height * mj_verticalRatio());
    }
    return CGSizeMake(size.width * mj_hotizontalRatio(), size.height * mj_verticalRatio());
}

DH_INLINE CGRect mj_flexibleFrame(CGRect frame,BOOL adjustWidth) {
    //拿到frame的center,然后对x y等比例缩放
    CGPoint center = mj_centerFromFrame(frame);
    center = mj_flexibleCenter(center, adjustWidth);
    //对宽高等比例缩放，拿到一个CGSize
    CGSize size = mj_flexibleSize(frame.size, adjustWidth);
    //用上面等比例缩放后的center和size组成一个frame返回
    return mj_frameWithSizeAndCenter(size, center);
}

DH_INLINE CGFloat mj_flexibleHeight(CGFloat height) {
    return height * mj_verticalRatio();
}

DH_INLINE CGFloat mj_flexibleWidth(CGFloat width) {
    return width * mj_hotizontalRatio();
}

DH_INLINE CGFloat mj_flexibleReverseHeight(CGFloat height) {
    return height / mj_verticalRatio();
}

DH_INLINE NSString * hxd_deviceType() {
    
    struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
        
        //------------------------------iPhone---------------------------
        if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
        if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
        if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
        if ([platform isEqualToString:@"iPhone3,1"] ||
            [platform isEqualToString:@"iPhone3,2"] ||
            [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
        if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
        if ([platform isEqualToString:@"iPhone5,1"] ||
            [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
        if ([platform isEqualToString:@"iPhone5,3"] ||
            [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
        if ([platform isEqualToString:@"iPhone6,1"] ||
            [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
        if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
        if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
        if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
        if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
        if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
        if ([platform isEqualToString:@"iPhone9,1"] ||
            [platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
        if ([platform isEqualToString:@"iPhone9,2"] ||
            [platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
        if ([platform isEqualToString:@"iPhone10,1"] ||
            [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
        if ([platform isEqualToString:@"iPhone10,2"] ||
            [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
        if ([platform isEqualToString:@"iPhone10,3"] ||
            [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
        if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
        if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
        if ([platform isEqualToString:@"iPhone11,4"] ||
            [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
        if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
        if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
        if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
        if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2nd Gen";
        if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
        if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
        if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
        if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";

        //------------------------------iPad--------------------------
        if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
        if ([platform isEqualToString:@"iPad2,1"] ||
            [platform isEqualToString:@"iPad2,2"] ||
            [platform isEqualToString:@"iPad2,3"] ||
            [platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
        if ([platform isEqualToString:@"iPad3,1"] ||
            [platform isEqualToString:@"iPad3,2"] ||
            [platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
        if ([platform isEqualToString:@"iPad3,4"] ||
            [platform isEqualToString:@"iPad3,5"] ||
            [platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
        if ([platform isEqualToString:@"iPad6,11"] ||
            [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
        if ([platform isEqualToString:@"iPad7,5"] ||
            [platform isEqualToString:@"iPad7,6"]) return @"iPad 6";
        if ([platform isEqualToString:@"iPad7,11"] ||
            [platform isEqualToString:@"iPad7,12"]) return @"iPad 7";
        if ([platform isEqualToString:@"iPad11,6"] ||
            [platform isEqualToString:@"iPad11,7"]) return @"iPad 8";

        //------------------------------iPad Pro-----------------------
        if ([platform isEqualToString:@"iPad6,3"] ||
            [platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
        if ([platform isEqualToString:@"iPad6,7"] ||
            [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
        if ([platform isEqualToString:@"iPad7,1"] ||
            [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
        if ([platform isEqualToString:@"iPad7,3"] ||
            [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
        if ([platform isEqualToString:@"iPad8,1"] ||
            [platform isEqualToString:@"iPad8,2"] ||
            [platform isEqualToString:@"iPad8,3"] ||
            [platform isEqualToString:@"iPad8,4"]) return @"iPad Pro 11 inch";
        if ([platform isEqualToString:@"iPad8,9"] ||
            [platform isEqualToString:@"iPad8,10"]) return @"iPad Pro 11 inch 2";
        if ([platform isEqualToString:@"iPad8,5"] ||
            [platform isEqualToString:@"iPad8,6"] ||
            [platform isEqualToString:@"iPad8,7"] ||
            [platform isEqualToString:@"iPad8,8"]) return @"iPad Pro 12.9 inch 3";
        if ([platform isEqualToString:@"iPad8,11"] ||
            [platform isEqualToString:@"iPad8,12"]) return @"iPad Pro 12.9 inch 4";

        //------------------------------iPad Air-----------------------
        if ([platform isEqualToString:@"iPad4,1"] ||
            [platform isEqualToString:@"iPad4,2"] ||
            [platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
        if ([platform isEqualToString:@"iPad5,3"] ||
            [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
        if ([platform isEqualToString:@"iPad11,3"] ||
            [platform isEqualToString:@"iPad11,4"]) return @"iPad Air 3";
        if ([platform isEqualToString:@"iPad13,1"] ||
            [platform isEqualToString:@"iPad13,2"]) return @"iPad Air 4";

        //------------------------------iPad Mini-----------------------
        if ([platform isEqualToString:@"iPad2,5"] ||
            [platform isEqualToString:@"iPad2,6"] ||
            [platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
        if ([platform isEqualToString:@"iPad4,4"] ||
            [platform isEqualToString:@"iPad4,5"] ||
            [platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,7"] ||
            [platform isEqualToString:@"iPad4,8"] ||
            [platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
        if ([platform isEqualToString:@"iPad5,1"] ||
            [platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
        if ([platform isEqualToString:@"iPad11,1"] ||
            [platform isEqualToString:@"iPad11,2"]) return @"iPad mini 5";
        
        //------------------------------iTouch------------------------
        if ([platform isEqualToString:@"iPod1,1"]) return @"iTouch";
        if ([platform isEqualToString:@"iPod2,1"]) return @"iTouch2";
        if ([platform isEqualToString:@"iPod3,1"]) return @"iTouch3";
        if ([platform isEqualToString:@"iPod4,1"]) return @"iTouch4";
        if ([platform isEqualToString:@"iPod5,1"]) return @"iTouch5";
        if ([platform isEqualToString:@"iPod7,1"]) return @"iTouch6";
        if ([platform isEqualToString:@"iPod9,1"]) return @"iTouch7";
        
        //------------------------------Samulitor-------------------------------------
        if ([platform isEqualToString:@"i386"] ||
            [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
        
        return @"Unknown";
    
}




#endif /* MJAdaptScreenHelp_h */
