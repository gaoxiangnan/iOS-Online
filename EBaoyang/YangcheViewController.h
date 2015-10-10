//
//  YangcheViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@protocol YangcheViewControllerDelegate <NSObject>

- (void) changeTabbarIndex;
- (void) changeScene:(NSInteger)scene;

@end

@interface YangcheViewController : BaseViewController
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic, assign) id<YangcheViewControllerDelegate,NSObject> delegate;
@end