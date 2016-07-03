//
//  MainCollectionViewController.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/7/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "SWRevealViewController.h"
#import "StageInfoColCell.h"
#import "MainColViewModel.h"
#import "StageInfoModel.h"
#import "StageDetailViewController.h"
#import "UIImageView+AFNetworking.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "URLCostant.h"
@interface MainCollectionViewController ()

@end

@implementation MainCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ViewModel
    if (_mainColViewModel == nil) {
        _mainColViewModel = [[MainColViewModel alloc] initWithMainColViewController:self];
    }
    //initialize page
    _currentPage = -1;
    _maxPage = 0;
    
    //List stage
    if (_listStage == nil) {
        _listStage = [[NSMutableArray alloc] init];
    }
    //self.title = @"Collection";
    //Collection View
    _cvListStage.dataSource = self;
    _cvListStage.collectionViewLayout = [self flowLayout];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([StageInfoColCell class]) bundle:[NSBundle mainBundle]];
    [_cvListStage registerNib:nib forCellWithReuseIdentifier:@"StageInfoColCell"];
    //For SWRevealViewController
//    SWRevealViewController *swRevealVC = [self revealViewController];
//    [swRevealVC panGestureRecognizer];
//    [swRevealVC tapGestureRecognizer];
//    UIImage *imgMenu = [UIImage imageNamed:@"Menu-50.png"];
//    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:imgMenu style:UIBarButtonItemStylePlain target:swRevealVC action:@selector(revealToggle:)];
//    
//    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

-(UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    
    flowLayout.itemSize = CGSizeMake(150.0f, 150.0f);
    flowLayout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return flowLayout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_currentPage < _maxPage) {
        return _listStage.count + 1;
    }
    return _listStage.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StageInfoColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StageInfoColCell" forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([StageInfoColCell class]) owner:self options:nil];
        cell = nibs[0];
    }
    if (indexPath.row ==  _listStage.count) {
        cell.hidden = YES;
    } else {
        cell.hidden = NO;
        StageInfoModel *stageInfo = [_listStage objectAtIndex:indexPath.row];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:stageInfo.thumbImage] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:REQUEST_TIMEOUT];
        [cell.imgStage setImageWithURLRequest:urlRequest
                             placeholderImage:[UIImage imageNamed:@"img_no_preview.jpg"]
                                      success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                          [cell.imgStage setImage:image];
                                          [cell.spin stopAnimating];
                                          cell.spin.hidden = YES;
                                      }
                                      failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                          [cell.imgStage setImage:[UIImage imageNamed:@"img_no_preview.jpg"]];
                                      }];
        
//        if (stageInfo && stageInfo.thumbImage) {
//            [_mainColViewModel downloadImageFromStringUrl:stageInfo.thumbImage thenCallBack:^(id  _Nonnull data) {
//                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:data]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [cell.imgStage setImage:img];
//                    cell.spin.hidden = YES;
//                });
//            } orNonReachable:^(NSString * _Nonnull message) {
//                NSLog(@"%@",message);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    cell.spin.hidden = YES;
//                });
//            }];
//        }
        
//        SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
//        [imageManager downloadImageWithURL:[NSURL URLWithString:stageInfo.thumbImage]
//                                   options:0
//                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                      //Progressing
//                                  }
//                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                     if (image && error == nil) {
//                                         [cell.imgStage setImage:image];
//                                         [cell.spin stopAnimating];
//                                         cell.spin.hidden = YES;
//                                     } else {
//                                         cell.spin.hidden = YES;
//                                     }
//                                 }];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _listStage.count) {
        if (_currentPage == -1) {
            //First loading
            _currentPage = 0;
            [_mainColViewModel addListStageFromPageNo:++_currentPage withHUD:YES];
        } else {
            [_mainColViewModel addListStageFromPageNo:++_currentPage withHUD:NO];
        }
        
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_listStage && _listStage.count > 0) {
        StageInfoModel *stageInfo = [_listStage objectAtIndex:indexPath.row];
        
        StageDetailViewController *stageDetailVC = [[StageDetailViewController alloc] init];
        [stageDetailVC initializeStageWithId:stageInfo.stageId];
        [self.navigationController pushViewController:stageDetailVC animated:YES];
    }
}
@end
