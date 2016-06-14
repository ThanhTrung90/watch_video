//
//  APINSURLSession.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/8/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "APINSURLSession.h"
#import "URLCostant.h"
@interface APINSURLSession()
@property (strong, nonatomic) NSURLSession *urlSession;
@end
@implementation APINSURLSession
-(id)initWithConfig:(SessionConfiguration)sessionConfig {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *urlSessionConfig = nil;
        switch (sessionConfig) {
            case SessionConfigurationEphemeral:
                urlSessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
                break;
            case SessionConfigurationBackground:
                urlSessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"bmhhBackgroundSessionIdentifier"];
                break;
            case SessionConfigurationDefault:
            default:
                urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
                break;
        }
        _urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
//        _urlSession = [NSURLSession sharedSession];
    }
    return self;
}
-(void)getApiFromStringUrl:(NSString *)strUrl withHeaders:(NSDictionary<NSString *,NSString *> *)headers andParameters:(NSDictionary<NSString *,NSString *> *)parameters thenCallBack:(ApiCallBack)callBack completionCallBack:(CompletionCallBack)completionCallBack orNonReachable:(ProcessNonReachable)processNonReachable {
    int index = 0;
    if (parameters && parameters.count > 0) {
        strUrl = [strUrl stringByAppendingString:@"?"];
        for (NSString *key in parameters.allKeys) {
            NSString *value = [parameters objectForKey:key];
            strUrl = [strUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            if (index < parameters.count -1) {
                strUrl = [strUrl stringByAppendingString:@"&"];
            }
            index ++;
        }
        
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"GET"];
    if (headers && headers.count > 0) {
        for (NSString *key in headers.allKeys) {
            NSString *value = [headers objectForKey:key];
            [request setValue:value forHTTPHeaderField:key];
        }
    }
    
    [[_urlSession dataTaskWithRequest:request
                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       if (error) {
                           //Error
                           NSLog(@"%@",error.description);
                           completionCallBack();
                           processNonReachable(@"Có lỗi trong quá trình lấy dữ liệu. Hãy thử lại!");
                       } else {
                           if (response) {
                               NSError *parseError = nil;
                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                               if (parseError) {
                                   NSLog(@"Parse json error : %@",parseError.description);
                                   completionCallBack();
                                   processNonReachable(@"Có lỗi trong quá trình lấy dữ liệu. Hãy thử lại!");
                               } else {
                                   callBack(dict);
                                   completionCallBack();
                               }
                           } else {
                               //Not response
                               NSLog(@"Not response");
                               completionCallBack();
                               processNonReachable(@"Có lỗi trong quá trình lấy dữ liệu. Hãy thử lại!");
                           }
                       }
                   }
    ] resume];
}
-(void)downloadImageFromStringUrl:(NSString *)strURl thenCallBack:(DataCallBack)callBack completionCallBack:(CompletionCallBack)completionCallBack orNonReachable:(ProcessNonReachable)processNonReachable{
    NSURL *url = [NSURL URLWithString:strURl];
    [[_urlSession downloadTaskWithURL:url
                   completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       if (error) {
                           NSLog(@"Error on download image : %@",error.description);
                       } else {
                           if (location) {
                               callBack(location);
                           } else {
                               NSLog(@"No image !");
                           }
                       }
                       completionCallBack();
                   }] resume];
}
@end
