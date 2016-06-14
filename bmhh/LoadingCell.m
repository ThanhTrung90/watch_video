//
//  LoadingCell.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/6/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_actIndicator startAnimating];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
