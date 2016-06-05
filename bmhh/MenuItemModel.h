//
//  MenuItemModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    MenuItemLastest,
    MenuItemMaxView,
    MenuItemImpression,
    MenuItemPairs,
    MenuItemConfide
}MenuItemType;
@interface MenuItemModel : NSObject
@property (strong, nonatomic) NSString *name;
-(id) initWithType : (MenuItemType) type;
-(MenuItemType) getTypeOfMenu;
@end
