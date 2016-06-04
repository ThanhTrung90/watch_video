//
//  StageDetailViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StageDetailViewController;
@interface StageDetailViewModel : NSObject
-(id) initWithStageDetailViewController : (StageDetailViewController *)stageDetailVC;
-(void) retrieveStageDetailWithId : (NSString *)stageId;
@end
