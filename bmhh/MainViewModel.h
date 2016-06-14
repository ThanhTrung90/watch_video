//
//  MainViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@class MainViewController;
@class StageInfoModel;

@interface MainViewModel : BaseViewModel
-(id) initWithViewController : (MainViewController *) mainVC;
-(void) addListStageFromPageNo : (NSInteger) pageNo withHUD : (BOOL) isDisplayHUD;
@end
