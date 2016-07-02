//
//  StageDetailModel.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "StageDetailModel.h"

@implementation StageDetailModel
-(id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = [dict objectForKey:@"Name"] == nil ? @"" : [dict objectForKey:@"Name"];
        NSString *link = [dict objectForKey:@"YoutubeLink"] == nil ? @"" : [dict objectForKey:@"YoutubeLink"];
        _realYoutubeLink = link;
        NSArray *arr = [link componentsSeparatedByString:@"/"];
        if (arr && arr.count > 0) {
            _youtubeLink = arr[arr.count - 1];
        } else {
            _youtubeLink = nil;
        }
    }
    return self;
}
@end
