//
//  StageDetailModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StageDetailModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *realYoutubeLink;
@property (strong, nonatomic) NSString *youtubeLink;
-(id) initWithDictionary : (NSDictionary *)dict;
@end
