//
//  StageDetailViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageDetailViewController.h"
#import "StageDetailViewModel.h"
#import "SWRevealViewController.h"

@interface StageDetailViewController ()

@end

@implementation StageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_stageDetailVM == nil) {
        _stageDetailVM = [[StageDetailViewModel alloc] initWithStageDetailViewController:self];
        [_stageDetailVM retrieveStageDetailWithId:_stageId];
    }
    
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
- (IBAction)shareToFacebook:(id)sender {
    [_stageDetailVM bmhhShareToFB];
}
- (IBAction)sendToMessageFB:(id)sender {
    [_stageDetailVM bmhhSendToMessageFB];
}
@end
