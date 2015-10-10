//
//  BaseViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/9/7.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property (nonatomic, strong)UIWebView *baseView;
@property (nonatomic, strong)NSURL *baseURL;
@property (nonatomic, strong)NSString *urlString;

- (void)updateViews;
- (void)setBaseURL:(NSURL *)baseURL;
- (BOOL)willStartLoadWithRequest:(NSURLRequest *)request;
@end
