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
#import "SWRevealViewController.h"
#import "LoadingCell.h"
@interface MainViewController()

@end
@implementation MainViewController
/* Start variable*/
static NSString *identifierCell = @"StageInfoCell";
static NSString *loadingCell = @"LoadingCell";
/* End variable*/

-(void)viewDidLoad{
    [super viewDidLoad];
    if (_mainViewModel == nil) {
        _mainViewModel = [[MainViewModel alloc] initWithViewController:self];
    }
    if (_listStage == nil) {
        _listStage = [[NSMutableArray alloc] init];
    }
    _currentPage = -1;
    _totalPage = 0;
    _tblStageInfo.hidden = YES;
    
    self.title = @"Bạn muốn hẹn hò";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //For SWRevealViewController
    SWRevealViewController *swRevealVC = [self revealViewController];
    [swRevealVC panGestureRecognizer];
    [swRevealVC tapGestureRecognizer];
    UIImage *imgMenu = [UIImage imageNamed:@"Menu-50.png"];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:imgMenu style:UIBarButtonItemStylePlain target:swRevealVC action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _listStage.count) {
        return 30;
    }
    return 120.0;
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
    if (_currentPage == _totalPage) {
        return _listStage.count;
    }
    return _listStage.count + 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _listStage.count) {
        if (_currentPage == -1) {
            _currentPage = 0;
            [_mainViewModel addListStageFromPageNo:++_currentPage withHUD:YES];
        } else {
            [_mainViewModel addListStageFromPageNo:++_currentPage withHUD:NO];
        }
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _listStage.count) {
        LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:loadingCell];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:loadingCell owner:self options:nil];
            cell = nibs[0];
        }
        [cell setHidden:YES];
        return cell;
    } else {
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
//        [_mainViewModel downloadImageFromStringUrl:stageInfo.thumbImage
//                                      thenCallBack:^(id  _Nonnull data) {
//                                          UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:data]];
//                                          dispatch_async(dispatch_get_main_queue(), ^{
//                                              [cell.imgStage setImage:img];
//                                          });
//                                      }
//                                    orNonReachable:^(NSString * _Nonnull message) {
//                                        NSLog(@"Can't connect internet");
//        }];
        return cell;
    }
}
@end
