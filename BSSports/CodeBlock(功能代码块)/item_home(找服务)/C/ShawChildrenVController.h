//
//  ShawChildrenVController.h
//  BSSports
//
//  Created by shaw on 2022/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    ShawChildrenVC_All,//全部
    ShawChildrenVC_Football, //足球
    ShawChildrenVC_Basketball,//篮球
    ShawChildrenVC_Esports,// 电竞
    ShawChildrenVC_Tennis,// 网球
    ShawChildrenVC_Baseball,// 棒球
    ShawChildrenVC_Entertainment,// 娱乐
}ShawChildrenStatus;

@interface ShawChildrenVController : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic,assign)ShawChildrenStatus status;

- (instancetype)init:(ShawChildrenStatus)status;
@end

NS_ASSUME_NONNULL_END
