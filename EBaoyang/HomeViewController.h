//
//  HomeViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class MasterViewController;

@protocol HomeViewControllerDelegate <NSObject>

- (void) sendTextContents:(NSString *)huaiData;
- (void) changeScenes:(NSInteger)scene;
@end

@interface HomeViewController : BaseViewController
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic, assign) id<HomeViewControllerDelegate,NSObject> delegate;
@property (nonatomic, strong) MasterViewController *masterVC;

@end
