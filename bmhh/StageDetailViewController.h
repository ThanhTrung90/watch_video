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
@interface StageDetailViewController : UIViewController
@property (strong, nonatomic) StageDetailViewModel *stageDetailVM;

@property (strong, nonatomic) NSString *stageId;
@property (weak, nonatomic) IBOutlet UITextView *txvStageName;
@property (weak, nonatomic) IBOutlet YTPlayerView *ytPlayerView;

-(void) initializeStageWithId : (NSString *)stageId;
@end
