//
//  StageInfoModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageInfoModel.h"

@implementation StageInfoModel
-(id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _stageId = [dict valueForKey:@"StageID"] == nil ? @"" : [dict valueForKey:@"StageID"];
        _thumbImage = [dict valueForKey:@"ThumbImage"] == nil ? @"" : [dict valueForKey:@"ThumbImage"];
        _name = [dict valueForKey:@"Name"] == nil ? @"" : [dict valueForKey:@"Name"];
        _shortDescription = [dict valueForKey:@"ShortDescription"] == nil ? @"" : [dict valueForKey:@"ShortDescription"];
        _rating = [dict valueForKey:@"Rating"] == nil ? @"" : [dict valueForKey:@"Rating"];
        _likeTotal = [dict valueForKey:@"LikeTotal"] == nil ? @"" : [dict valueForKey:@"LikeTotal"];
        _shareTotal = [dict valueForKey:@"ShareTotal"] == nil ? @"" : [dict valueForKey:@"ShareTotal"];
    }
    return self;
}
@end
