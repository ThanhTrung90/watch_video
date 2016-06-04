//
//  StageInfoCell.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageInfoCell.h"

@implementation StageInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.txvDesStage.editable = NO;
    self.txvDesStage.scrollEnabled = NO;
    self.spin.hidden = NO;
    [self.spin startAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
