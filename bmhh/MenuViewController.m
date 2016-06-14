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
#import "MainCollectionViewController.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
@interface MenuViewController (){
    NSArray *listMenuItems;
    NSInteger currentRow;
}
@property (weak, nonatomic) IBOutlet UITableView *tblMenu;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentRow = -1;
    if (_menuViewModel == nil) {
        _menuViewModel = [[MenuViewModel alloc] initWithViewController:self];
        listMenuItems = [_menuViewModel listMenuItems];
    }
    _tblMenu.tableFooterView = [[UIView alloc] init];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRevealViewController *revealVC = [self revealViewController];
    if (indexPath.section == currentRow) {
        [revealVC setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    MenuItemModel *item = [listMenuItems objectAtIndex:indexPath.section];
    
    UIViewController *vc = nil;
    if (item) {
        switch (item.getTypeOfMenu) {
            case MenuItemLastest:
            {
                MainCollectionViewController *mainColVC = [[MainCollectionViewController alloc] init];
                vc = mainColVC;
            }
                break;
            case MenuItemMaxView:
            {
                MainViewController *mainVC = [[MainViewController alloc] init];
                vc = mainVC;
            }
                break;
            default:
                break;
        }
    }
    if (vc) {
        vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        UINavigationController *frontNav = [[UINavigationController alloc] initWithRootViewController:vc];
        [revealVC pushFrontViewController:frontNav animated:YES];
    }
    currentRow = indexPath.section;
}
@end
