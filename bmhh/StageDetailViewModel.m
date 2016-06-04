//
//  StageDetailViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageDetailViewModel.h"
#import "StageDetailViewController.h"
#import "APIAFNetworking.h"
#import "URLCostant.h"
#import "Utils.h"
#import "StageDetailModel.h"
#import <AVFoundation/AVFoundation.h>
@interface StageDetailViewModel()
@property (weak, nonatomic) StageDetailViewController *stageDetailVC;
@property (strong, nonatomic) id<APIProtocol> api;
@end
@implementation StageDetailViewModel
-(id)initWithStageDetailViewController:(StageDetailViewController *)stageDetailVC {
    self = [super init];
    if (self) {
        _stageDetailVC = stageDetailVC;
        _stageDetailVC.stageDetailVM = self;
        
        _api = [[APIAFNetworking alloc] init];
    }
    return self;
}
-(void)retrieveStageDetailWithId:(NSString *)stageId {
    NSMutableArray *listAction = [[NSMutableArray alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [listAction addObject:cancelAction];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self retrieveStageDetailWithId:stageId];
    }];
    [listAction addObject:tryAgainAction];
    
    NSString *url = [NSString stringWithFormat:RETRIEVE_STAGE,stageId];
    [_api getApiFromStringUrl:url
                 withHeader:nil
                 thenCallBack:^(id  _Nonnull responseObject) {
                     NSDictionary *dict = responseObject;
                     StageDetailModel *detailModel = [[StageDetailModel alloc] initWithDictionary:dict];
                     if (detailModel) {
                         _stageDetailVC.txvStageName.text = detailModel.name;
                         if (detailModel.youtubeLink) {
                             NSDictionary *playerVars = @{
                                                          @"playsinline" : @1,
                                                          @"autoplay" : @1,
                                                          @"disablekb" :@1
                                                          };
                             [_stageDetailVC.ytPlayerView loadWithVideoId:detailModel.youtubeLink playerVars:playerVars];
                             [_stageDetailVC.ytPlayerView playVideo];
                             NSError *setCategoryError = nil;
                             [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
                         }
                     }
                 } orNonReachable:^{
                     [Utils createAlertForViewController:_stageDetailVC withTitle:@"Warning" andMessage:@"Không kết nối được internet !" andListAction:listAction];
                 }
    ];
}
@end
