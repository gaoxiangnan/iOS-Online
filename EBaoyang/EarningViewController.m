//
//  EarningViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "EarningViewController.h"
#import "AppDelegate.h"
#import "ProgressHUD.h"
#import "MasterViewController.h"

@interface EarningViewController ()<UIWebViewDelegate>

@end

@implementation EarningViewController
-(void)viewDidAppear:(BOOL)animated
{
//    [self.tabBarController.view.layer addAnimation:[DeviceSelect CAtransitionUpdate] forKey:nil];
//    self.hidesBottomBarWhenPushed = NO;
    [self updateViews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    
//    [self.tabBarController.view.layer addAnimation:[DeviceSelect CAtransitionUpdate] forKey:nil];
}
//- (void)onTextBtn
//{
//    MasterViewController *masterVC = [[MasterViewController alloc]init];
//    masterVC.urlString = @"www.baidu.com";
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:masterVC animated:NO];
//}
- (void)viewDidLoad {
    [super viewDidLoad];

    

    
//    self.view.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-70)];
    self.webView.delegate = self;
//    NSURL *url2 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/earning"];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/earning",INTERURL]];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    [self.webView loadRequest:request2];
    [self.view addSubview:self.webView];
    //禁止UIWebView下拉拖动效果
    for(id subview in self.webView.subviews){
        
        if([[subview class] isSubclassOfClass:[UIScrollView class]])
            
            ((UIScrollView *)subview).bounces = NO;
    }
    
    //After iOS 5
    self.webView.scrollView.bounces = NO;    // Do any additional setup after loading the view.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLstring = [[request URL] absoluteString];
    NSLog(@"URLstring is %@",URLstring);
    [ProgressHUD show:nil];

    
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
//    NSURL *url2 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/earning"];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/earning",INTERURL]];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    [self.webView loadRequest:request2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
