//
//  Utils.m
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/31/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(void)createAlertForViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message andListAction:(NSArray<UIAlertAction *> *)listAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (listAction && listAction.count > 0) {
        for (UIAlertAction *alertAction in listAction) {
            [alertController addAction:alertAction];
        }
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
