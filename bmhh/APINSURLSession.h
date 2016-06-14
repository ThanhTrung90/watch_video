//
//  APINSURLSession.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 6/8/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"
typedef enum{
    SessionConfigurationDefault,
    SessionConfigurationBackground,
    SessionConfigurationEphemeral
} SessionConfiguration;
@interface APINSURLSession : NSObject<APIProtocol>
- (id) initWithConfig : (SessionConfiguration) sessionConfig;
@end
