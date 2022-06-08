//
//  UserManger.m
//  ToAskLive
//
//  Created by __ on 2020/12/24.
//

#import "UserManger.h"
#import <MMKV/MMKV.h>

/*用户储存字段*/
//用户数据
#define user_info    @"__userinfo__"


@interface UserManger()

@property (nonatomic,strong)MMKV *myMMkv;
@property (nonatomic,assign)BOOL isRequestCos;
@end

@implementation UserManger

+(instancetype)shareManger
{
    static UserManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger =  [[UserManger alloc]init];
        
    });
    return manger;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myMMkv = [MMKV defaultMMKV];
//        [self getUserInfo];
    }
    return self;
}

//-(void)getUserInfo
//{
//
//    NSDictionary *model = [self.myMMkv getObjectOfClass:[NSDictionary class] forKey:user_info];
//    if (model) {
//        self.userInfo = [UserInfoModel mj_objectWithKeyValues:model];
//    }
//}
-(void)clearInfo
{
    [self.myMMkv removeValueForKey:user_info];
//    self.userInfo = nil;
    
}
//-(void)updateUsinfo:(MyUserInfoModel*)userM
//{
//    if (self.userInfo) {
//        self.userInfo.avatar = userM.avatar;
//        self.userInfo.user_nickname = userM.user_nickname;
//        self.userInfo.sex = userM.sex;
//        self.userInfo.birthday = userM.birthday;
//        self.userInfo.is_anchor = userM.is_anchor;
//        [self.myMMkv setObject:[self.userInfo mj_JSONObject] forKey:user_info];
//    }
//}
//-(void)goLoginUserInfo:(UserInfoModel *)model
//{
////    self.myMMkv getObjectOfClass:<#(nonnull Class)#> forKey:<#(nonnull NSString *)#>
////    [[MMKV defaultMMKV] getObjectOfClass:NSMutableArray.class forKey:key];
//
//    self.userInfo = model;
//
//    [self.myMMkv setObject:[model mj_JSONObject] forKey:user_info];
//
//}

-(BOOL)isLogin
{
    if([self.myMMkv getObjectOfClass:[NSDictionary class] forKey:user_info]){
        return YES;
    }
    return NO;

}
///**获取腾讯云上传配置*/
//-(void)getConfigCos:(void(^)(BOOL succes))back
//{
//    kWeakSelf(self)
//    if (_isRequestCos) {
//        return;
//    }
//    _isRequestCos = YES;
//
//    [PPHTTPRequest getKConfigCosParameters:nil success:^(id response) {
//        weakself.isRequestCos = NO;
//        if (response[@"data"]) {
//            weakself.cosModel = [ConfigCosModel mj_objectWithKeyValues:response[@"data"]];
//            back(YES);
//        }else{
//            back(NO);
//        }
//
//    } failure:^(NSInteger code, NSString *error) {
//        weakself.isRequestCos = NO;
//        back(NO);
//    }];
//}

@end

@implementation UserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

//+ (NSDictionary *)mj_objectClassInArray {
//    return @{
//        @"list" : [WCPCalendarDayDataModel class]
//         };
//}
@end

@implementation ConfigCosModel

@end
