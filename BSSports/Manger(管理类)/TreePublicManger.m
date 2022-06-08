//
//  TreePublicManger.m
//  ToAskLive
//
//  Created by __ on 2021/1/9.
//

#import "TreePublicManger.h"
//#import <QCloudCOSXML/QCloudCOSXML.h>
//#import <WXApi.h>

@implementation TreePublicManger

///**腾讯上传*/
//+(void)QCloudUpdateImage:(UIImage*)image
//                    rand:(int)rand
//callBack:(void(^)(BOOL isSucces, NSString *key))Callback
//{
//    NSData *data = UIImagePNGRepresentation(image);
//    QCloudCOSXMLUploadObjectRequest* put = [QCloudCOSXMLUploadObjectRequest new];
//    // 本地文件路径
////    NSURL* url = [NSURL fileURLWithPath:@"文件的URL"];
//    // 存储桶名称，格式为 BucketName-APPID
//    put.bucket = UserM.cosModel.bucket;
//    // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
//    put.object = [NSString stringWithFormat:@"goAsk-%@-%d-%@",UserM.userInfo.ID,rand,[emptyjudge getNowTimeTimestampnew]];
//    //需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
//    put.body =  data;
//    //监听上传进度
//    [put setSendProcessBlock:^(int64_t bytesSent,
//                                int64_t totalBytesSent,
//                                int64_t totalBytesExpectedToSend) {
//        //      bytesSent                   新增字节数
//        //      totalBytesSent              本次上传的总字节数
//        //      totalBytesExpectedToSend    本地上传的目标字节数
//    }];
//
//    //监听上传结果
////    [MBProgressHUD showtoView:self.mainTwoview];
////    WeakSelf(self);
//    [put setFinishBlock:^(id outputObject, NSError *error) {
//        //可以从 outputObject 中获取 response 中 etag 或者自定义头部等信息
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            if (error) {
//                NSString *errStr = [error localizedDescription];
//                Callback(NO,errStr);
//            }else{
//    //            [self.updaImgUrl addObject: ]
//                QCloudUploadObjectResult * result = (QCloudUploadObjectResult *)outputObject;
//                NSLog(@"上传结果%@",result);
//                if ([result isKindOfClass:[QCloudUploadObjectResult class]]) {
//                    Callback(YES,result.key);
//                }else{
//                    Callback(NO,@"数据错误");
//                }
//            }
//        });
//    }];
//    [[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
//}
///**腾讯上传文件*/
//+(void)QCloudUpdateFilePath:(NSString*)filePath
//callBack:(void(^)(BOOL isSucces, NSString *key))Callback
//{
//
//    QCloudCOSXMLUploadObjectRequest* put = [QCloudCOSXMLUploadObjectRequest new];
//    // 本地文件路径
//    NSURL* url = [NSURL fileURLWithPath:filePath];
//    // 存储桶名称，格式为 BucketName-APPID
//    put.bucket = UserM.cosModel.bucket;
//    // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
//    put.object = [NSString stringWithFormat:@"goAsk-%@-%@.mp3",UserM.userInfo.ID,[emptyjudge getNowTimeTimestampnew]];
//    //需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
//    put.body =  url;
//    //监听上传进度
//    [put setSendProcessBlock:^(int64_t bytesSent,
//                                int64_t totalBytesSent,
//                                int64_t totalBytesExpectedToSend) {
//        //      bytesSent                   新增字节数
//        //      totalBytesSent              本次上传的总字节数
//        //      totalBytesExpectedToSend    本地上传的目标字节数
//    }];
//
//    //监听上传结果
////    [MBProgressHUD showtoView:self.mainTwoview];
////    WeakSelf(self);
//    [put setFinishBlock:^(id outputObject, NSError *error) {
//        //可以从 outputObject 中获取 response 中 etag 或者自定义头部等信息
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            if (error) {
//                NSString *errStr = [error localizedDescription];
//                Callback(NO,errStr);
//            }else{
//    //            [self.updaImgUrl addObject: ]
//                QCloudUploadObjectResult * result = (QCloudUploadObjectResult *)outputObject;
//                NSLog(@"上传结果%@",result);
//                if ([result isKindOfClass:[QCloudUploadObjectResult class]]) {
//                    Callback(YES,result.key);
//                }else{
//                    Callback(NO,@"数据错误");
//                }
//            }
//        });
//    }];
//    [[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
//}
//+(void)QcloudDown:(NSString*)key
//         callBack:(void(^)(BOOL isSucces, NSString *key))Callback;
//{
//    if (UserM.cosModel.bucket.length == 0) {
//        [MBProgressHUD showErrorMessage:@"腾讯上传没有桶"];
//        return;
//    }
//    QCloudCOSXMLDownloadObjectRequest * request = [QCloudCOSXMLDownloadObjectRequest new];
//
//    // 存储桶名称，格式为 BucketName-APPID
//    request.bucket = UserM.cosModel.bucket;
//
//    // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
//    request.object = key;
//
//    // 设置下载的路径 URL，如果设置了，文件将会被下载到指定路径中
//    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"SoundFile"];
//    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",key]];
//    request.downloadingURL = [NSURL fileURLWithPath:filePath];
//
//    // 本地已下载的文件大小，如果是从头开始下载，请不要设置
//    request.localCacheDownloadOffset = 100;
//
//    // 监听下载结果
//    [request setFinishBlock:^(id outputObject, NSError *error) {
//        // outputObject 包含所有的响应 http 头部
//        NSDictionary* info = (NSDictionary *) outputObject;
//        NSLog(@"%@",info);
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            if (error) {
//                NSString *errStr = [error localizedDescription];
//                Callback(NO,@"资源数据错误");
//            }else{
//                NSLog(@"下载结果%@",info);
//                Callback(YES,filePath);
//            }
//        });
//    }];
//
//    // 监听下载进度
//    [request setDownProcessBlock:^(int64_t bytesDownload,
//                                   int64_t totalBytesDownload,
//                                   int64_t totalBytesExpectedToDownload) {
//
//        // bytesDownload                   新增字节数
//        // totalBytesDownload              本次下载接收的总字节数
//        // totalBytesExpectedToDownload    本次下载的目标字节数
//    }];
//
//    [[QCloudCOSTransferMangerService defaultCOSTransferManager] DownloadObject:request];
//}
///**wecat分享-- 网页类型*/
//+(void)wecatShare:(NSString*)url
//         titleStr:(NSString*)title
//          descrip:(NSString*)desip
//            image:(NSString*)image
//{
//
//    WXWebpageObject *webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = url;
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = title;
//    message.description = desip;
//
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
//    UIImage * result = [UIImage imageWithData:data];
//    [message setThumbImage:result];
//    message.mediaObject = webpageObject;
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneSession;
//    [WXApi sendReq:req completion:^(BOOL success) {
//
//    }];
////    //我的是把微信自检屏蔽就好了
////    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult * _Nonnull result)
////     {
////        NSLog(@"-------------%ld\n%@",step,result);
////    }];
////    [WXApi openWXApp];
//}

@end
