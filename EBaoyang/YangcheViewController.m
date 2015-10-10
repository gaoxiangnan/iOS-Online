//
//  YangcheViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "YangcheViewController.h"
#import "AppDelegate.h"
#import "ProgressHUD.h"
#import "GXNAleartView.h"
#import "MasterViewController.h"

@interface YangcheViewController ()<UIWebViewDelegate,UIActionSheetDelegate>

@end

@implementation YangcheViewController
-(void)viewWillDisappear:(BOOL)animated
{
//    [self.tabBarController.view.layer addAnimation:[DeviceSelect CAtransitionUpdate] forKey:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    [self updateViews];
//    [self.tabBarController.view.layer addAnimation:[DeviceSelect CAtransitionUpdate] forKey:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-64)];
//    NSURL *url3 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/yangche"];
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/yangche",INTERURL]];
    
    self.webView.delegate = self;
    NSURLRequest *request3 = [NSURLRequest requestWithURL:url3];
    [self.webView loadRequest:request3];
    [self.view addSubview:self.webView];
    
    //禁止UIWebView下拉拖动效果
    for(id subview in self.webView.subviews){
        if([[subview class] isSubclassOfClass:[UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    }
    //After iOS 5
    self.webView.scrollView.bounces = NO;
    
    // Do any additional setup after loading the view.
    
}
- (void)textBtn
{
    [GXNAleartView GXNAleartWitVersionhView:self.view versionSure:^{
        NSLog(@"我点了确定");
    } cancleBlock:^{
        NSLog(@"我点了取消");
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [ProgressHUD show:nil];
   
    NSString *URLstring = [[request URL] absoluteString];
    NSLog(@"URLstring is %@",URLstring);
    
    NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
    if ([request URL].query) {
        for (int i = 0; i < urlArr.count; i++) {
            if ([urlArr[i] isEqualToString:@"action=open"]) {
                [ProgressHUD dismiss];
                MasterViewController *masterVC = [[MasterViewController alloc]init];
                masterVC.urlString = URLstring;
                [self.navigationController pushViewController:masterVC animated:YES];
                return NO;
            }
        }
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}
- (void)updateViews
{
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/yangche",INTERURL]];
    
    self.webView.delegate = self;
    NSURLRequest *request3 = [NSURLRequest requestWithURL:url3];
    [self.webView loadRequest:request3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


@end
