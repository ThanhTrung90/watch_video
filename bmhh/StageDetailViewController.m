//
//  StageDetailViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageDetailViewController.h"
#import "StageDetailViewModel.h"
@interface StageDetailViewController ()

@end

@implementation StageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_stageDetailVM == nil) {
        _stageDetailVM = [[StageDetailViewModel alloc] initWithStageDetailViewController:self];
        [_stageDetailVM retrieveStageDetailWithId:_stageId];
    }
    
    self.title = @"Detail";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//retrieve data
-(void)initializeStageWithId:(NSString *)stageId {
    _stageId = stageId;
}
@end