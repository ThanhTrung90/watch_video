//
//  MainCollectionViewController.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/7/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainColViewModel;
@interface MainCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *listStage;
@property (strong, nonatomic) MainColViewModel *mainColViewModel;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger maxPage;

@property (weak, nonatomic) IBOutlet UICollectionView *cvListStage;
@end
