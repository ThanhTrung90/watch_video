//
//  MenuViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/5/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewModel.h"
#import "MenuItemModel.h"
@interface MenuViewController (){
    NSArray *listMenuItems;
}
@property (weak, nonatomic) IBOutlet UITableView *tblMenu;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_menuViewModel == nil) {
        _menuViewModel = [[MenuViewModel alloc] initWithViewController:self];
        listMenuItems = [_menuViewModel listMenuItems];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Menu Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numbers = 0;
    if (listMenuItems) {
        numbers = listMenuItems.count;
    }
    return numbers;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuItemModel *item = [listMenuItems objectAtIndex:indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuItemCell"];
    cell.textLabel.text = item.name;
    return cell;
}
@end
