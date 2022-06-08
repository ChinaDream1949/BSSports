//
//  LocationManger.h
//  ToAskLive
//
//  Created by __ on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManger : NSObject

+(instancetype)shareManger;
@property (nonatomic,strong)NSString* strlatitude;//经度
@property (nonatomic,strong)NSString* strlongitude;//纬度
-(void)updateLocation;
@end

NS_ASSUME_NONNULL_END
