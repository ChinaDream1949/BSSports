//
//  ShawInformationVController.h
//  BSSports
//
//  Created by shaw on 2022/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    ShawInformation_All,//全部
    ShawInformation_Hot, //足球
    ShawInformation_Champions,//篮球
}ShawInformationStatus;

@interface ShawInformationVController : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic,assign)ShawInformationStatus status;
- (instancetype)init:(ShawInformationStatus)status;

@end

NS_ASSUME_NONNULL_END
