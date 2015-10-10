//
//  DeviceSelect.m
//  EBaoyang
//
//  Created by ebaoyang on 15/8/7.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "DeviceSelect.h"
#include <sys/sysctl.h>

@implementation DeviceSelect
+ (CATransition *)CAtransitionUpdate
{
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.5];
    [transition setType:@"rippleEffect"];
    [transition setSubtype:kCATransitionFromRight];
    return transition;
}

+ (Reachability *)netReachability
{
    
        Reachability *netReachability = [Reachability reachabilityForInternetConnection];
        [netReachability startNotifier];
    
    return  netReachability;
}
+ (NSString *)getDeviceId
{
    DeviceSelect *deviceString = [[DeviceSelect alloc]init];
    return [deviceString getCurrentDeviceModel];
}
+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
- (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadMini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadMini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadMini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadMini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadMini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadMini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
