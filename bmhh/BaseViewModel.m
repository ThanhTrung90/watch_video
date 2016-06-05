//
//  BaseViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "BaseViewModel.h"
#import "APIAFNetworking.h"
@interface BaseViewModel(){
    id<APIProtocol> api;
}

@end

@implementation BaseViewModel
-(id) init {
    self = [super init];
    if (self) {
        api = [[APIAFNetworking alloc] init];
    }
    return self;
}
-(void)getApiFromStringUrl:(NSString *)strUrl withHeaders:(NSDictionary<NSString *,NSString *> *)headers andParameters : (NSDictionary<NSString *,NSString *> *)parameters thenCallBack:(ApiCallBack)callBack orNonReachable:(ProcessNonReachable)processNonReachable{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    HUD.mode = MBProgressHUDAnimationFade;
    [api getApiFromStringUrl:strUrl
                  withHeaders:headers
                andParameters:parameters
                thenCallBack:callBack
          completionCallBack:^{
              [HUD setHidden:YES];
          }
              orNonReachable:processNonReachable];
}

@end
