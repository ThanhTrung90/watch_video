//
//  MainColViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/8/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MainColViewModel.h"
#import "MainCollectionViewController.h"
#import "URLCostant.h"
#import "StageInfoModel.h"
#import "Utils.h"
@interface MainColViewModel()
@property (weak, nonatomic) MainCollectionViewController *mainColVC;
@end
@implementation MainColViewModel
-(id)initWithMainColViewController:(MainCollectionViewController *)mainColVC{
    self = [super initWithTypeAPIUsed:TypeLibURLSession];
    if (self) {
        _mainColVC = mainColVC;
        _mainColVC.mainColViewModel = self;
    }
    return self;
}
-(void)addListStageFromPageNo : (NSInteger) pageNo withHUD : (BOOL) isDisplayHUD {
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
    [params setObject:[NSString stringWithFormat:@"%d",(int)PAGE_SIZE] forKey:@"pageSize"];
    if (isDisplayHUD) {
        [self getApiWithHUDFromStringUrl:LIST_STAGE
                             withHeaders:headers
                           andParameters:params
                            thenCallBack:^(id _Nonnull responseObject){
                                [self processResponseObject:responseObject];
                            }
                          orNonReachable:^(NSString* message){
                              [Utils createAlertForViewController:_mainColVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
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
                       [Utils createAlertForViewController:_mainColVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
                   }
         ];
    }
}

-(void) processResponseObject : (id _Nonnull) responseObject {
    NSDictionary *dict = (NSDictionary *) responseObject;
    NSString *strTotalRecord = dict[@"TotalRecord"];
    NSInteger totalRecord = [strTotalRecord integerValue];
    if (totalRecord%PAGE_SIZE == 0) {
        _mainColVC.maxPage = totalRecord/PAGE_SIZE;
    } else {
        _mainColVC.maxPage = totalRecord/PAGE_SIZE + 1;
    }
    NSMutableArray *mubArrStage = [[NSMutableArray alloc] init];
    NSArray *arrStages = dict[@"Records"];
    if (arrStages && arrStages.count > 0) {
        for (int i = 0; i <arrStages.count; i++) {
            NSDictionary *dictStage = arrStages[i];
            StageInfoModel *stageInfo = [[StageInfoModel alloc] initWithDictionary:dictStage];
            if (stageInfo) {
                [mubArrStage addObject:stageInfo];
            }
        }
    }
    if (mubArrStage.count > 0) {
        [_mainColVC.listStage addObjectsFromArray:mubArrStage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mainColVC.cvListStage reloadData];
        });
    }
}
@end
