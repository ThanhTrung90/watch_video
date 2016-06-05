//
//  BaseViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"
#import "MBProgressHUD.h"
@interface BaseViewModel : NSObject
-(void) getApiFromStringUrl : (NSString* _Nonnull)strUrl
                 withHeader : (NSDictionary<NSString *,NSString *>  * _Nullable)headers
               thenCallBack : (ApiCallBack _Nonnull)callBack
             orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@end
