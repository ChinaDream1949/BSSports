//
//  WCPBaseModel.m
//  yunbaolive
//
//  Created by hs on 2020/11/26.
//  Copyright © 2020 cat. All rights reserved.
//

#import "WCPBaseModel.h"
#import "MJExtension.h"

@implementation WCPBaseModel
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    
    //    NSLog(@"oldValue:%@ %@ = %@",property.name,property.type.typeClass,oldValue);
    // if (oldValue == nil || [oldValue isEqual:[NSNull null]] || oldValue == NULL || [oldValue isEqual:@"(null)"] || [oldValue isEqual:@"<null>"] || [oldValue isEqual:@""])
    
    if (oldValue == nil || [oldValue isEqual:[NSNull null]] || oldValue == NULL || [oldValue isEqual:@"(null)"] || [oldValue isEqual:@"<null>"] || [oldValue isEqual:@""])
    {
        if ([property.type.typeClass  isEqual:[NSMutableDictionary class]]){
           
            return @{};
        }else if ([property.type.typeClass  isEqual:[NSDictionary class]]){
            
            return @{};
        }else if ([property.type.typeClass  isEqual:[NSArray class]]){
            
            return @[];
        }else if ([property.type.typeClass isEqual:[NSMutableArray class]]){
            
            return @[];
        }else if ([property.type.typeClass isEqual:[NSString class]]){
            
            return @"";

        }else if ([property.type.typeClass isEqual:[NSNumber class]]){
            
            return @(0);
        }

    }
    return oldValue;
    
//    if ([property.type.typeClass  isEqual:[NSMutableDictionary class]]){
//        //            NSLog(@"%@",@{});
//        return @{};
//    }else if ([property.type.typeClass  isEqual:[NSDictionary class]]){
//        //            NSLog(@"%@",@{});
//        return @{};
//    }else if ([property.type.typeClass  isEqual:[NSArray class]]){
//        //            NSLog(@"%@",@[]);
//        return @[];
//    }else if ([property.type.typeClass isEqual:[NSMutableArray class]]){
//        //            NSLog(@"%@",@[]);
//        return @[];
//    }else if ([property.type.typeClass isEqual:[NSString class]]){
//        //            NSLog(@"%@",@"12");
//        return @"";
//
//    }else if ([property.type.typeClass isEqual:[NSNumber class]]){
//        //            NSLog(@"%@",@(0));
//        return @(0);
//    }
//    return oldValue;
    
}
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
//{
//
//    if (oldValue == [NSNull null]) {
//
//        if ([oldValue isKindOfClass:[NSArray class]]) {
//
//            return  @[];
//
//        }else if([oldValue isKindOfClass:[NSDictionary class]]){
//
//            return @{};
//
//        }else{
//
//            return @"";
//
//        }
//    }
//}
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
//{
//    if ([NSString isEmpty:oldValue])
//    {
//        // 以字符串类型为例
//        return  @"";
//    }
//    return oldValue;
//}
//+(BOOL)isEmpty:(NSString*)text{
//    if ([text isEqual:[NSNull null]]) {
//        return YES;
//    }
//    else if ([text isKindOfClass:[NSNull class]])
//    {
//        return YES;
//    }
//    else if (text == nil){
//        return YES;
//    }
//    return NO;
//}

//使用
//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"ID": @"id"};
//}
//+ (NSDictionary *)mj_objectClassInArray {
//    return @{
//        @"list" : [WCPCalendarDayDataModel class]
//         };
//}
@end
