//
//  MenuViewModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MenuViewModel.h"
#import "MenuViewController.h"
#import "MenuItemModel.h"
@interface MenuViewModel()
@property (weak, nonatomic) MenuViewController *menuVC;
@end;
@implementation MenuViewModel
-(id)initWithViewController:(MenuViewController *)menuVC {
    self = [super init];
    if (self) {
        _menuVC = menuVC;
        _menuVC.menuViewModel = self;
    }
    return self;
}
-(NSArray *)listMenuItems {
    NSMutableArray *listItems = [[NSMutableArray alloc] init];
    MenuItemModel *itemLastest = [[MenuItemModel alloc] initWithType:MenuItemLastest];
    [listItems addObject:itemLastest];
    
    MenuItemModel *itemMaxView = [[MenuItemModel alloc] initWithType:MenuItemMaxView];
    [listItems addObject:itemMaxView];
    
    MenuItemModel *itemImpression = [[MenuItemModel alloc] initWithType:MenuItemImpression];
    [listItems addObject:itemImpression];
    
    MenuItemModel *itemPairs = [[MenuItemModel alloc] initWithType:MenuItemPairs];
    [listItems addObject:itemPairs];
    
    MenuItemModel *itemConfide = [[MenuItemModel alloc] initWithType:MenuItemConfide];
    [listItems addObject:itemConfide];
    
    return listItems;
}
@end
