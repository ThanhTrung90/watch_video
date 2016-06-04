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
@interface MainViewModel()
@property (weak, nonatomic) MainViewController *mainVC;
@property (strong, nonatomic) id<APIProtocol> api;
@end
@implementation MainViewModel
-(id)initWithViewController:(MainViewController *)mainVC {
    self = [super init];
    if (self) {
        _mainVC = mainVC;
        _mainVC.mainViewModel = self;
        _api = [[APIAFNetworking alloc] init];
    }
    return self;
}
-(void)listStage{
    NSMutableArray *listAction = [[NSMutableArray alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [listAction addObject:cancelAction];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self listStage];
    }];
    [listAction addObject:tryAgainAction];
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"DCAC3003-5CEB-4631-8C1D-427DADEE1BC2" forKey:@"secret-key"];
    [_api getApiFromStringUrl:LIST_STAGE
                   withHeader:headers
                 thenCallBack:^(id _Nonnull responseObject){
                     NSMutableArray *mutableArrStage = [[NSMutableArray alloc] init];
                     NSArray *arr = responseObject;
                     for (int i = 0; i < arr.count; i++) {
                         NSDictionary *dict = arr[i];
                         StageInfoModel *stage = [[StageInfoModel alloc] initWithDictionary:dict];
                         if (stage) {
                             [mutableArrStage addObject:stage];
                         }
                     }
                     _mainVC.listStage = mutableArrStage;
                     [_mainVC.tblStageInfo reloadData];
                 }
                 orNonReachable:^{
                     [Utils createAlertForViewController:_mainVC withTitle:@"Warning !" andMessage:@"Không kết nối được internet !" andListAction:listAction];
                 }
    ];
}
-(StageInfoModel *)stageAtIndex:(NSInteger)index {
    StageInfoModel *stage = [[StageInfoModel alloc] init];
    stage.thumbImage = @"https://i.ytimg.com/vi/pM9Fezmwy_Q/hqdefault.jpg";
    stage.shortDescription = @"BẠN MUỐN HẸN HÒ - Tập 10 | Đức Anh - Ái Loan | Hoàng Linh - Thanh Tâm | 12/01/2014";
    stage.name = @"BẠN MUỐN HẸN HÒ - Tập 10 | Đức Anh - Ái Loan | Hoàng Linh - Thanh Tâm | 12/01/2014";
    stage.rating = @"7";
    stage.shareTotal = @"123";
    stage.likeTotal = @"323";
    return stage;
}
-(NSArray *)listStageOfPageIndex:(NSInteger)pageIndex withPageSize:(NSInteger)pageSize {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<pageSize; i++) {
        StageInfoModel *stage = [[StageInfoModel alloc] init];
        stage.thumbImage = @"https://i.ytimg.com/vi/pM9Fezmwy_Q/hqdefault.jpg";
        stage.shortDescription = @"BẠN MUỐN HẸN HÒ - Tập 10 | Đức Anh - Ái Loan | Hoàng Linh - Thanh Tâm | 12/01/2014";
        stage.name = @"BẠN MUỐN HẸN HÒ - Tập 10 | Đức Anh - Ái Loan | Hoàng Linh - Thanh Tâm | 12/01/2014";
        stage.rating = @"7";
        stage.shareTotal = @"123";
        stage.likeTotal = @"323";
        [arr addObject:stage];
    }
    return arr;
}
@end
