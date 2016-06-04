//
//  APIUrlConnection.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "APIUrlConnection.h"
#import "URLCostant.h"

@implementation APIUrlConnection
-(NSArray *)listStage {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSString *strUrl = LIST_STAGE;
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:METHOD_GET];
    [urlRequest setTimeoutInterval:REQUEST_TIMEOUT];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSDate *now = [NSDate date];
    NSLog(@"%@", now.description);
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            NSError * error = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSLog(@"%@",[jsonObject description]);
            }
            NSLog(@"%@",[jsonObject description]);
        } else {
            NSLog(@"Error : %@",connectionError.description);
        }
    }];
    return arr;
}
@end
