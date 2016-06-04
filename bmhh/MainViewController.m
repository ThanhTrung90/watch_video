//
//  MainViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "StageInfoModel.h"
#import "StageInfoCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLCostant.h"
#import "StageDetailViewController.h"
@interface MainViewController()

@end
@implementation MainViewController
/* Start variable*/
static NSString *identifierCell = @"StageInfoCell";

/* End variable*/

-(void)viewDidLoad{
    if (_mainViewModel == nil) {
        _mainViewModel = [[MainViewModel alloc] initWithViewController:self];
    }
    [_mainViewModel listStage];
    self.title = @"Main";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= (scrollView.contentSize.height - scrollView.bounds.size.height)) {
        
    } else {
        
    }
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"To Top");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_listStage && _listStage.count > 0) {
        StageInfoModel *stageInfo = [_listStage objectAtIndex:indexPath.section];
        
        StageDetailViewController *stageDetailVC = [[StageDetailViewController alloc] init];
        [stageDetailVC initializeStageWithId:stageInfo.stageId];
        [self.navigationController pushViewController:stageDetailVC animated:YES];
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger number = 0;
    if (_listStage) {
        number = _listStage.count;
    }
    if (number == 0) {
        _tblStageInfo.hidden = YES;
    } else {
        _tblStageInfo.hidden = NO;
    }
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StageInfoModel *stageInfo = [_listStage objectAtIndex:indexPath.section];
    
    StageInfoCell *cell = (StageInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierCell owner:self options:nil];
        cell = nib[0];
    }
    cell.txvDesStage.text = stageInfo.shortDescription;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:stageInfo.thumbImage]  cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:REQUEST_TIMEOUT];
    [cell.imgStage setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"img_no_preview.jpg"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [cell.imgStage setImage:image];
        [cell.spin stopAnimating];
        cell.spin.hidden = YES;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        [cell.imgStage setImage:[UIImage imageNamed:@"img_no_preview.jpg"]];
    }];
    return cell;
}
@end
