//
//  StageDetailViewController.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
@class StageDetailViewModel;
@class FBSDKShareButton;
@interface StageDetailViewController : UIViewController
@property (strong, nonatomic) StageDetailViewModel *stageDetailVM;

@property (strong, nonatomic) NSString *stageId;

@property (weak, nonatomic) IBOutlet YTPlayerView *ytPlayerView;
@property (weak, nonatomic) IBOutlet UIStackView *mainStackView;

-(void) initializeStageWithId : (NSString *)stageId;
@end
