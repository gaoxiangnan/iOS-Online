//
//  WalletViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "WalletViewController.h"
#import "AppDelegate.h"
#import "MasterViewController.h"
#import "QRViewController.h"
#import "ProgressHUD.h"

@interface WalletViewController ()<UIWebViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,MasterViewControllerDelegate>

@end

@implementation WalletViewController
-(void)viewWillDisappear:(BOOL)animated
{
//    [self.tabBarController.view.layer addAnimation:[DeviceSelect CAtransitionUpdate] forKey:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self updateViews];
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
    self.webView.delegate = self;
//    NSURL *url4 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/my/wallet"];
    NSURL *url4 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/my/wallet",INTERURL]];
    NSURLRequest *request4 = [NSURLRequest requestWithURL:url4];
    [self.webView loadRequest:request4];
    [self.view addSubview:self.webView];
    
    //禁止UIWebView下拉拖动效果
    for(id subview in self.webView.subviews){
        
        if([[subview class] isSubclassOfClass:[UIScrollView class]])
            
            ((UIScrollView *)subview).bounces = NO;
    }
    
    //After iOS 5
    self.webView.scrollView.bounces = NO;
    
}
- (void)updateOtherViews
{
    NSURL *url4 = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"GETDATA"]];
    NSURLRequest *request4 = [NSURLRequest requestWithURL:url4];
    [self.webView loadRequest:request4];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GETDATA"];
}
- (void)updateViews
{
//    NSURL *url4 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/my/wallet"];
    NSURL *url4 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/my/wallet",INTERURL]];
    NSURLRequest *request4 = [NSURLRequest requestWithURL:url4];
    [self.webView loadRequest:request4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [ProgressHUD show:nil];
    NSString *requestString = [[request URL] absoluteString];

    
    NSLog(@"%@",requestString);
    
//    if ([requestString isEqualToString:@"http://qianbao.ebaoyang.com/h5/my/bill/sys"]) {
//        [ProgressHUD dismiss];
//        QRViewController *secVC = [[QRViewController alloc]init];
//        [self.navigationController pushViewController:secVC animated:YES];
//        return NO;
//        
//    }
    if ([requestString isEqualToString:[NSString stringWithFormat:@"%@h5/my/bill/sys",INTERURL]]) {
        [ProgressHUD dismiss];
        QRViewController *secVC = [[QRViewController alloc]init];
        [self.navigationController pushViewController:secVC animated:YES];
        return NO;
        
    }

    NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
    if ([request URL].query) {
        for (int i = 0; i < urlArr.count; i++) {
            if ([urlArr[i] isEqualToString:@"action=open"]) {
                [ProgressHUD dismiss];
                self.masterVC = [[MasterViewController alloc]init];
                self.masterVC.urlString = requestString;
                self.masterVC.delegate = self;
                [self.navigationController pushViewController:self.masterVC animated:YES];
                return NO;
            }
        }
    }
//    if ([requestString isEqualToString:@"http://qianbao.ebaoyang.com/h5/index?action=back&direction=right"]) {
//        appDelegate.tabBarController.selectedIndex = 0;
//    }
    if ([requestString isEqualToString:[NSString stringWithFormat:@"%@h5/index?action=back&direction=right",INTERURL]]) {
        appDelegate.tabBarController.selectedIndex = 0;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}


- (void) sendTextContent:(NSString *)huaiData
{
    NSLog(@"%@",huaiData);
    if (_delegate) {
        [_delegate sendTextContents:huaiData];
    }
}
- (void) changeScene:(NSInteger)scene
{
    NSLog(@"%ld",(long)scene);
    [_delegate changeScenes:scene];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
