//
//  UserManger.h
//  ToAskLive
//
//  Created by __ on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import "WCPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

//@class UserInfoModel;
//@class ConfigCosModel;
//用户模型
@interface UserManger : NSObject

-(instancetype)init NS_UNAVAILABLE;
+(instancetype)shareManger;

/**判断是否登录*/
-(BOOL)isLogin;
/**设置用户信息*/
//-(void)goLoginUserInfo:(UserInfoModel *)model;
///**更新用户信息*/
//-(void)updateUsinfo:(MyUserInfoModel *)userM;
/**清除用户信息*/
-(void)clearInfo;
/**获取腾讯云上传配置*/
-(void)getConfigCos:(void(^)(BOOL succes))back;

//@property (nonatomic,strong)UserInfoModel *__nullable userInfo;

@end


@interface UserInfoModel : WCPBaseModel
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *user_nickname;//": "手机用户：3321",
/**1男 2女*/
@property (nonatomic,copy)NSString *sex;//": 0,
@property (nonatomic,copy)NSString *birthday;//": null,
@property (nonatomic,copy)NSString *create_time;//": 1608877170,
@property (nonatomic,copy)NSString *avatar;//": "",
@property (nonatomic,copy)NSString *constellation;//": "",
@property (nonatomic,copy)NSString *user_level;//": 1,
@property (nonatomic,copy)NSString *anchor_level;//": null,
@property (nonatomic,copy)NSString *is_anchor;//": 0,
@property (nonatomic,copy)NSString *token;//": "bcd751c37e1be5bc99d14cc778e962d605c33515713f5bde28a19703b843028f"

@end

@interface ConfigCosModel : WCPBaseModel
@property (nonatomic,copy)NSString *region;
@property (nonatomic,copy)NSString *secretId;
@property (nonatomic,copy)NSString *secretKey;
@property (nonatomic,copy)NSString *bucket;
@end

#define UserM [UserManger shareManger]



NS_ASSUME_NONNULL_END
