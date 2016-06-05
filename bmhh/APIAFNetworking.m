//
//  APIAFNetworking.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "APIAFNetworking.h"

#import "AFNetWorking.h"
#import "StageInfoModel.h"
#import "URLCostant.h"
@implementation APIAFNetworking
-(void)getApiFromStringUrl:(NSString *)strUrl withHeaders:(NSDictionary<NSString *,NSString *> * _Nullable)headers andParameters:(NSDictionary<NSString *,NSString *> * _Nullable)parameters thenCallBack:(ApiCallBack _Nonnull)callBack completionCallBack:(CompletionCallBack _Nonnull)completionCallBack orNonReachable:(ProcessNonReachable _Nonnull)processNonReachable{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            completionCallBack();
            processNonReachable(@"Hãy kiểm tra lại kết nối Internet của bạn.");
        } else {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
            //initialize request
            requestSerializer.timeoutInterval = REQUEST_TIMEOUT;
            if (headers && headers.count > 0) {
                for (NSString *key in headers.allKeys) {
                    NSString *value = [headers objectForKey:key];
                    [requestSerializer setValue:value forHTTPHeaderField:key];
                }
            }
            manager.requestSerializer = requestSerializer;
            
            AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
            responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
            manager.responseSerializer = responseSerializer;
            
            [manager GET:strUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"%@",downloadProgress.description);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    callBack(responseObject);
                    completionCallBack();
                } else {
                    NSLog(@"Not response");
                    completionCallBack();
                    processNonReachable(@"Có lỗi trong quá trình lấy dữ liệu. Hãy thử lại!");
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error.description);
                completionCallBack();
                processNonReachable(@"Có lỗi trong quá trình lấy dữ liệu. Hãy thử lại!");
            }];
        }
    }];
}
@end
