//
//  StageInfoModel.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StageInfoModel : NSObject
@property (strong, nonatomic) NSString *stageId;
@property (strong, nonatomic) NSString *thumbImage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *likeTotal;
@property (strong, nonatomic) NSString *shareTotal;
-(id) initWithDictionary : (NSDictionary *)dict;
@end
