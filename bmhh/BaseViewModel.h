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

typedef enum {
    TypeLibAFNetworking,
    TypeLibURLSession
}TypeLibNetworking;

@interface BaseViewModel : NSObject
-(id _Nullable) initWithTypeAPIUsed : (TypeLibNetworking) typeLib;
-(void) getApiWithHUDFromStringUrl : (NSString* _Nonnull)strUrl
                withHeaders : (NSDictionary<NSString *,NSString *> * _Nullable)headers
              andParameters : (NSDictionary<NSString *,NSString *> * _Nullable)parameters
               thenCallBack : (ApiCallBack _Nonnull)callBack
             orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
-(void) getApiFromStringUrl : (NSString* _Nonnull)strUrl
                       withHeaders : (NSDictionary<NSString *,NSString *> * _Nullable)headers
                     andParameters : (NSDictionary<NSString *,NSString *> * _Nullable)parameters
                      thenCallBack : (ApiCallBack _Nonnull)callBack
                    orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
-(void) downloadImageFromStringUrl : (NSString * _Nonnull)strURl thenCallBack : (DataCallBack _Nonnull)callBack orNonReachable : (ProcessNonReachable _Nonnull)processNonReachable;
@end
