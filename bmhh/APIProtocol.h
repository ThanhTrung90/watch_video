//
//  APIProtocol.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ApiCallBack)(id _Nonnull responseObject);
typedef void (^ProcessNonReachable)(NSString* _Nonnull message);
typedef void (^CompletionCallBack)(void);

typedef void  (^DataCallBack)(id _Nonnull data);
@protocol APIProtocol <NSObject>
-(void) getApiFromStringUrl : (NSString * _Nonnull)strUrl withHeaders : (NSDictionary<NSString *,NSString *>  * _Nullable)headers andParameters : (NSDictionary<NSString *,NSString *> * _Nullable) parameters thenCallBack : (ApiCallBack _Nonnull)callBack completionCallBack :(CompletionCallBack _Nonnull)completionCallBack orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@optional
-(void) downloadImageFromStringUrl : (NSString * _Nonnull)strURl thenCallBack : (DataCallBack _Nonnull)callBack completionCallBack :(CompletionCallBack _Nonnull)completionCallBack orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@end
