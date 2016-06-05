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

#define PAGE_SIZE       5

@interface BaseViewModel : NSObject
-(void) getApiFromStringUrl : (NSString* _Nonnull)strUrl
                withHeaders : (NSDictionary<NSString *,NSString *> * _Nullable)headers
              andParameters : (NSDictionary<NSString *,NSString *> * _Nullable)parameters
               thenCallBack : (ApiCallBack _Nonnull)callBack
             orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@end
