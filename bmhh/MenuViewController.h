//
//  MenuViewController.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewModel;
@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) MenuViewModel *menuViewModel;
@end
