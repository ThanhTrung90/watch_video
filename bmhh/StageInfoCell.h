//
//  StageInfoCell.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgStage;
@property (weak, nonatomic) IBOutlet UITextView *txvDesStage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spin;

@end
