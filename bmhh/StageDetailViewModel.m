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
#import "MarqueeLabel.h"
#import <AVFoundation/AVFoundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface StageDetailViewModel()
@property (weak, nonatomic) StageDetailViewController *stageDetailVC;
@property (strong, nonatomic) StageDetailModel *detailModel;
@end
@implementation StageDetailViewModel
-(id)initWithStageDetailViewController:(StageDetailViewController *)stageDetailVC {
    self = [super initWithTypeAPIUsed:TypeLibAFNetworking];
    if (self) {
        _stageDetailVC = stageDetailVC;
        _stageDetailVC.stageDetailVM = self;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oriented) name:UIDeviceOrientationDidChangeNotification object:nil];
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
                     _detailModel = [[StageDetailModel alloc] initWithDictionary:dict];
                     if (_detailModel) {
                         _stageDetailVC.title = _detailModel.name;
                         if (_detailModel.youtubeLink) {
                             NSDictionary *playerVars = @{
                                                          @"playsinline" : @1,
                                                          @"autoplay" : @1,
                                                          @"disablekb" :@1
                                                          };
                             [_stageDetailVC.ytPlayerView loadWithVideoId:_detailModel.youtubeLink playerVars:playerVars];
                             [_stageDetailVC.ytPlayerView playVideo];
                             NSError *setCategoryError = nil;
                             [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 CGFloat width = _stageDetailVC.view.frame.size.width;
                                 [self orientationForWidth:width];
                             });
                         }
                     }
                 } orNonReachable:^(NSString* message){
                     [Utils createAlertForViewController:_stageDetailVC withTitle:@"Lỗi" andMessage:message andListAction:listAction];
                 }
    ];
}
-(void)bmhhShareToFB {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:_detailModel.realYoutubeLink];
    [FBSDKShareDialog showFromViewController:_stageDetailVC withContent:content delegate:nil];
}
-(void)bmhhSendToMessageFB {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:_detailModel.realYoutubeLink];
    [FBSDKMessageDialog showWithContent:content delegate:nil];
}
#pragma mark - change orientation
-(void) oriented {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat size = _stageDetailVC.view.frame.size.width;
        [self orientationForWidth:size];
    });
}
-(void) orientationForWidth : (CGFloat)width {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*2/3, 30)];
    MarqueeLabel *marqueeLabel = [[MarqueeLabel alloc] initWithFrame:titleView.bounds duration:8.0 andFadeLength:10.0f];
    marqueeLabel.text = _stageDetailVC.title;
    marqueeLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:marqueeLabel];
    _stageDetailVC.navigationItem.titleView = titleView;
}
@end
