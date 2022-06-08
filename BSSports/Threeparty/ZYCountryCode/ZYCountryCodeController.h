//
//  ZYCountryCodeController.h
//  Wayii
//
//  Created by zy on  2021/8/13.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^returnCountryCodeBlock) (NSString *countryName, NSString *code);

@protocol ZYCountryCodeControllerDelegate <NSObject>

@optional

/**
 Delegate 回调所选国家代码

 @param countryName 所选国家
 @param code 所选国家代码
 */
-(void)returnCountryName:(NSString *)countryName code:(NSString *)code;

@end





@interface ZYCountryCodeController : ViewController

@property (nonatomic, weak) id<ZYCountryCodeControllerDelegate> deleagete;

@property (nonatomic, copy) returnCountryCodeBlock returnCountryCodeBlock;
@property (nonatomic, copy) void (^backBlock)(void);

@end

NS_ASSUME_NONNULL_END
