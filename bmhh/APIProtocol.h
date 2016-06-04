//
//  APIProtocol.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ApiCallBack)(id _Nonnull responseObject);
typedef void (^ProcessNonReachable)(void);
@protocol APIProtocol <NSObject>
-(void) getApiFromStringUrl : (NSString * _Nonnull)strUrl withHeader : (NSDictionary<NSString *,NSString *>  * _Nullable)headers thenCallBack : (ApiCallBack _Nonnull)callBack orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@end
