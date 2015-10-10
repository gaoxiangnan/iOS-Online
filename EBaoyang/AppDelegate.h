//
//  AppDelegate.h
//  EBaoyang
//
//  Created by ebaoyang on 15/7/14.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
#import "HomeViewController.h"
#import "EarningViewController.h"
#import "YangcheViewController.h"
#import "WalletViewController.h"
#import "DeviceSelect.h"

#import "WXApi.h"

typedef void (^checkUpdateBlock)();
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate>
{
    enum WXScene _scene;
}

@property (assign, nonatomic) int versionInt;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIImageView *splashView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) HomeViewController *homeVC;
@property (strong, nonatomic) EarningViewController *earningVC;
@property (strong, nonatomic) YangcheViewController *yangcheVC;
@property (strong, nonatomic) WalletViewController *walletVC;
@property (strong, nonatomic) NSArray *VCArray;
@property (strong, nonatomic) NSArray *webArray;
@property (strong, nonatomic) SecondViewController *secVC;
@property (strong, nonatomic) NSString *strMsg;
@property (strong, nonatomic) NSString *qiyeStr;
@property (strong, nonatomic) NSString *storeStr;
@property (assign, nonatomic) NSInteger tabbarIndex;

@property (copy, nonatomic ) checkUpdateBlock myBlock;


@end

