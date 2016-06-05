//
//  MenuViewModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuViewController;
@class MenuItemModel;
@interface MenuViewModel : NSObject
-(id) initWithViewController : (MenuViewController *)menuVC;
-(NSArray *) listMenuItems;
@end
