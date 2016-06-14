//
//  BaseViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "BaseViewModel.h"
#import "APIAFNetworking.h"
#import "APINSURLSession.h"
@interface BaseViewModel(){
    id<APIProtocol> api;
    TypeLibNetworking typeLibNetWorking;
}

@end

@implementation BaseViewModel
-(id)initWithTypeAPIUsed:(TypeLibNetworking)typeLib {
    self = [super init];
    if (self) {
        typeLibNetWorking = typeLib;
        switch (typeLib) {
            case TypeLibURLSession:
                api = [[APINSURLSession alloc] initWithConfig:SessionConfigurationDefault];
                break;
            case TypeLibAFNetworking:
            default:
                api = [[APIAFNetworking alloc] init];
                break;
        }
    }
    return self;
}

-(void)getApiWithHUDFromStringUrl:(NSString *)strUrl withHeaders:(NSDictionary<NSString *,NSString *> *)headers andParameters : (NSDictionary<NSString *,NSString *> *)parameters thenCallBack:(ApiCallBack)callBack orNonReachable:(ProcessNonReachable)processNonReachable{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    HUD.mode = MBProgressHUDAnimationFade;
    [api getApiFromStringUrl:strUrl
                  withHeaders:headers
                andParameters:parameters
                thenCallBack:callBack
          completionCallBack:^{
              dispatch_async(dispatch_get_main_queue(), ^{
                  [HUD setHidden:YES];
                  NSLog(@"Completion call back");
              });
          }
              orNonReachable:processNonReachable];
}

-(void)getApiFromStringUrl:(NSString *)strUrl withHeaders:(NSDictionary<NSString *,NSString *> *)headers andParameters:(NSDictionary<NSString *,NSString *> *)parameters thenCallBack:(ApiCallBack)callBack orNonReachable:(ProcessNonReachable)processNonReachable{
    [api getApiFromStringUrl:strUrl
                 withHeaders:headers
               andParameters:parameters
                thenCallBack:callBack
          completionCallBack:^{
              NSLog(@"Completion call back");
          }
              orNonReachable:processNonReachable];
}

-(void)downloadImageFromStringUrl:(NSString *)strURl thenCallBack:(DataCallBack)callBack orNonReachable:(ProcessNonReachable)processNonReachable {
    [api downloadImageFromStringUrl:strURl
                       thenCallBack:callBack
                 completionCallBack:^{
                     NSLog(@"Complete download : %@",strURl);
    
                 }
                     orNonReachable:processNonReachable
     ];
}
@end
