//
//  DeviceSelect.h
//  EBaoyang
//
//  Created by ebaoyang on 15/8/7.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface DeviceSelect : NSObject
{
    Reachability *_netReachability;
}
+ (Reachability *)netReachability;
+ (NSString *)getDeviceId;
- (NSString *)getCurrentDeviceModel;
+ (NSString *)getIOSVersion;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (CATransition *)CAtransitionUpdate;
@end
