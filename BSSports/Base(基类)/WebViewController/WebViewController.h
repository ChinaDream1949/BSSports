//
//  WebViewController.h
//  baseXCode
//
//  Created by __ on 2021/4/23.
//

#import "WCPRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : WCPRootViewController

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,copy)NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
