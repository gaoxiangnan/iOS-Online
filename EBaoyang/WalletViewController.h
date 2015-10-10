//
//  WalletViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MasterViewController.h"

@protocol WalletViewControllerDelegate <NSObject>

- (void) sendTextContents:(NSString *)huaiData;
- (void) changeScenes:(NSInteger)scene;

@end
@interface WalletViewController : BaseViewController
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic, assign) id<WalletViewControllerDelegate,NSObject> delegate;
@property (nonatomic, strong) NSString *huaiData;
@property (nonatomic, strong) MasterViewController *masterVC;

@end
