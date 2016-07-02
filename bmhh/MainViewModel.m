//
//  MainViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MainViewModel.h"
#import "MainViewController.h"
#import "APIAFNetworking.h"
#import "StageInfoModel.h"
#import "URLCostant.h"
#import "Utils.h"
#import "MBProgressHUD.h"
@interface MainViewModel()
@property (weak, nonatomic) MainViewController *mainVC;
@property (strong, nonatomic) id<APIProtocol> api;
@end
@implementation MainViewModel
-(id)initWithViewController:(MainViewController *)mainVC {
    self = [super initWithTypeAPIUsed:TypeLibAFNetworking];
    if (self) {
        _mainVC = mainVC;
        _mainVC.mainViewModel = self;
        _api = [[APIAFNetworking alloc] init];
    }
    return self;
}

-(void)addListStageFromPageNo : (NSInteger) pageNo withHUD : (BOOL) isDisplayHUD{
    NSMutableArray *listAction = [[NSMutableArray alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [listAction addObject:cancelAction];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addListStageFromPageNo : pageNo withHUD:isDisplayHUD];
    }];
    [listAction addObject:tryAgainAction];
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"DCAC3003-5CEB-4631-8C1D-427DADEE1BC2" forKey:@"secret-key"];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%d",(int)pageNo] forKey:@"CurrentPage"];
    [params setObject:[NSString stringWithFormat:@"%d",(int)BMHH_PAGE_SIZE] forKey:@"pageSize"];
    if (isDisplayHUD) {
        [self getApiWithHUDFromStringUrl:LIST_STAGE
                             withHeaders:headers
                           andParameters:params
                            thenCallBack:^(id _Nonnull responseObject){
                                [self processResponseObject:responseObject];
                            }
                          orNonReachable:^(NSString* message){
                              [Utils createAlertForViewController:_mainVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
                          }
         ];
    } else {
        [self getApiFromStringUrl:LIST_STAGE
                      withHeaders:headers
                    andParameters:params
                     thenCallBack:^(id  _Nonnull responseObject) {
                         [self processResponseObject:responseObject];
                     }
                   orNonReachable:^(NSString * _Nonnull message) {
                             [Utils createAlertForViewController:_mainVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
                   }
         ];
    }
}

-(void) processResponseObject : (id _Nonnull) responseObject{
    NSMutableArray *mutableArrStage = [[NSMutableArray alloc] init];
    NSDictionary *response = responseObject;
    NSString *strTotalStage = response[@"TotalRecord"];
    if (strTotalStage) {
        NSInteger totalRecord= [strTotalStage integerValue];
        if (totalRecord%BMHH_PAGE_SIZE == 0) {
            _mainVC.totalPage = totalRecord/BMHH_PAGE_SIZE;
        } else {
            _mainVC.totalPage = totalRecord/BMHH_PAGE_SIZE + 1;
        }
    }
    NSArray *listStage = response[@"Records"];
    for (int i = 0; i < listStage.count; i++) {
        NSDictionary *dict = listStage[i];
        StageInfoModel *stage = [[StageInfoModel alloc] initWithDictionary:dict];
        if (stage) {
            [mutableArrStage addObject:stage];
        }
    }
    if (mutableArrStage.count > 0) {
        [_mainVC.listStage addObjectsFromArray:mutableArrStage];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_mainVC.tblStageInfo.hidden) {
                _mainVC.tblStageInfo.hidden = NO;
            }
            [_mainVC.tblStageInfo reloadData];
        });
    }

}
@end
