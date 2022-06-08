//
//  RouteManger.h
//  ToAskLive
//
//  Created by __ on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteManger : NSObject

/**
 图片查看器
 @param datas 数据
 */
+(void)showBigImage:(NSArray *)datas
          indexPath:(NSIndexPath*)indexPath;
/**banner跳转*/
+(void)BannerJump:(UIViewController*)supVC;
@end

NS_ASSUME_NONNULL_END
