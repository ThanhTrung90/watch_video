//
//  MenuItemModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MenuItemModel.h"
@interface MenuItemModel(){
    MenuItemType itemType;
}
@end
@implementation MenuItemModel
-(id)initWithType:(MenuItemType)type {
    self = [super init];
    if (self) {
        itemType = type;
        switch (type) {
            case MenuItemLastest:
                _name = @"Mới nhất";
                break;
            case MenuItemMaxView:
                _name = @"Xem nhiều";
                break;
            case MenuItemImpression:
                _name = @"Ấn tượng - đẹp đôi";
                break;
            case MenuItemPairs:
                _name = @"Thành đôi";
                break;
            case MenuItemConfide:
                _name = @"Tâm sự";
                break;
            default:
                break;
        }
    }
    return self;
}
-(MenuItemType)getTypeOfMenu {
    return itemType;
}
@end
