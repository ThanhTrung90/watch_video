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
@end
@implementation StageDetailViewModel
-(id)initWithStageDetailViewController:(StageDetailViewController *)stageDetailVC {
    self = [super initWithTypeAPIUsed:TypeLibAFNetworking];
    if (self) {
        _stageDetailVC = stageDetailVC;
        _stageDetailVC.stageDetailVM = self;
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
    [self getApiWithHUDFromStringUrl:url
                 withHeaders:nil
                andParameters:nil
                 thenCallBack:^(id  _Nonnull responseObject) {
                     NSDictionary *dict = responseObject;
                     StageDetailModel *detailModel = [[StageDetailModel alloc] initWithDictionary:dict];
                     if (detailModel) {
                         _stageDetailVC.title = detailModel.name;
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
                 } orNonReachable:^(NSString* message){
                     [Utils createAlertForViewController:_stageDetailVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
                 }
    ];
}
@end
