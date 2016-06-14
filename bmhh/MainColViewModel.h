//
//  MainColViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/8/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@class MainCollectionViewController;
@interface MainColViewModel : BaseViewModel
-(id) initWithMainColViewController : (MainCollectionViewController *)mainColVC;
-(void)addListStageFromPageNo : (NSInteger) pageNo withHUD : (BOOL) isDisplayHUD;
@end
