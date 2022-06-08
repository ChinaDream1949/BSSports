//
//  LocationManger.m
//  ToAskLive
//
//  Created by __ on 2021/3/3.
//

#import "LocationManger.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManger ()

@property (nonatomic,strong)CLLocationManager* locationmanager;//定位服务

@end

@implementation LocationManger

+(instancetype)shareManger
{
    static LocationManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger =  [[LocationManger alloc]init];
        [manger startLocation];
        
    });
    return manger;
}
#pragma mark - 定位
//开始定位
-(void) startLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        _locationmanager = [[CLLocationManager alloc]init];
        _locationmanager.delegate = (id)self;
        [_locationmanager requestAlwaysAuthorization];
        [_locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationmanager.distanceFilter = 5.0;
//        [_locationmanager startUpdatingLocation];
    }
}
-(void)updateLocation
{
    [_locationmanager startUpdatingLocation];
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
//            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
//        }
//    }];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [_locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.strlatitude = [NSString stringWithFormat:@"%0.2f",currentLocation.coordinate.latitude];
    self.strlongitude = [NSString stringWithFormat:@"%0.2f",currentLocation.coordinate.longitude];
    //反地理编码
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
//    {
//        NSLog(@"反地理编码");
//        NSLog(@"反地理编码%ld",placemarks.count);
//        if (placemarks.count > 0) {
//            CLPlacemark *placeMark = placemarks[0];
//            /*看需求定义一个全局变量来接收赋值*/
//            NSLog(@"城市----%@",placeMark.country);//当前国家
//            NSLog(@"城市%@",self.label_city.text);//当前的城市
//            NSLog(@"%@",placeMark.subLocality);//当前的位置
//            NSLog(@"%@",placeMark.thoroughfare);//当前街道
//            NSLog(@"%@",placeMark.name);//具体地址
//
//        }
//    }];
    
}
@end
