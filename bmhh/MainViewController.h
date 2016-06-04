//
//  MainViewController.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewModel;
@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblStageInfo;

@property (strong, nonatomic) MainViewModel *mainViewModel;
@property (strong, nonatomic) NSArray *listStage;
@end
