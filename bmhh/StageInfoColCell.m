//
//  StageInfoColCell.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/8/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageInfoColCell.h"

@implementation StageInfoColCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_imgStage setImage:[UIImage imageNamed:@"img_no_preview.png"]];
    _spin.hidden = NO;
    [_spin startAnimating];
}

@end
