//
//  Utils.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject
+(void) createAlertForViewController : (UIViewController *)viewController withTitle : (NSString *)title andMessage : (NSString *)message andListAction : (NSArray<UIAlertAction *> *)listAction;
@end
