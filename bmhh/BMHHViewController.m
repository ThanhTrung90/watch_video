//
//  BMHHViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 7/1/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "BMHHViewController.h"
#import "CarbonKit.h"
#import "MainViewController.h"
#import "MainCollectionViewController.h"
@interface BMHHViewController () <CarbonTabSwipeNavigationDelegate> {
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
    NSArray *items;
}

@end

@implementation BMHHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Watch Video";
    items = @[@"Tất cả", @"Ấn tượng"];
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    [self style];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oriented) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - style
-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(void) style {
    
    UIColor *color = [UIColor colorWithRed:24.0 / 255 green:75.0 / 255 blue:152.0 / 255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:color];
    
    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:color font:[UIFont boldSystemFontOfSize:14]];
    
    [self oriented];
    
}

-(void) oriented {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat divide = items.count;
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width/divide forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width/divide forSegmentAtIndex:1];
}

#pragma mark - CarbonTabSwipeNavigationDelegate
-(UIViewController *)carbonTabSwipeNavigation:(CarbonTabSwipeNavigation *)carbonTabSwipeNavigation viewControllerAtIndex:(NSUInteger)index {
    UIViewController *viewController = nil;
    if (index == 0) {
        viewController = [[MainViewController alloc] init];
    } else {
        viewController = [[MainCollectionViewController alloc] init];
    }
    return viewController;
}

@end
