//
//  MainViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainViewController;
@class StageInfoModel;
@interface MainViewModel : NSObject
-(id) initWithViewController : (MainViewController *) mainVC;
-(void) listStage;
-(StageInfoModel *) stageAtIndex : (NSInteger)index;
-(NSArray *) listStageOfPageIndex : (NSInteger) pageIndex withPageSize : (NSInteger) pageSize;
@end
