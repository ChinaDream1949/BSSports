//
//  PactWKWebViewController.h
//  CargoSteward_CarrierShipper
//
//  Created by 华尚 on 2021/6/11.
//

#import "WCPRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PactWKWebViewController : WCPRootViewController

/** urlViewNavTitle
 */
@property (nonatomic,strong)NSString* titleStr;

/** urlView的url
 */
@property (nonatomic,strong)NSString* urlStr;

@end

NS_ASSUME_NONNULL_END
