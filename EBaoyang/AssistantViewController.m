//
//  AssistantViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/16.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "AssistantViewController.h"
#import "DeviceSelect.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"
#import "MasterViewController.h"

@interface AssistantViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) UIView *placeView;
@property (nonatomic, strong) UIScreen *myScreen;
@property (nonatomic, strong) UITabBar *tabbar;
@end

@implementation AssistantViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.mainWebView removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.versionA = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myScreen = [UIScreen mainScreen];
    self.mainWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.myScreen.bounds.size.width, self.myScreen.bounds.size.height-20)];
    self.mainWebView.delegate = self;
    self.mainWebView.scrollView.delegate = self;
    NSURL *url = [[NSURL alloc]initWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:request];
    
    
    //禁止UIWebView下拉拖动效果
    for(id subview in self.mainWebView.subviews){
        
        if([[subview class] isSubclassOfClass:[UIScrollView class]])
            
            ((UIScrollView *)subview).bounces = NO;
    }
    
    //After iOS 5
    self.mainWebView.scrollView.bounces = NO;
    
    [self.view addSubview:self.mainWebView];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.versionA ++;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [ProgressHUD show:nil];
    NSString *URLstring = [[request URL] absoluteString];
    NSLog(@"assistent URLstring is %@",URLstring);
    
    if (self.versionA%3 == 2) {
        NSLog(@"master除2的余数是0");
        NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
        if ([request URL].query) {
            for (int i = 0; i < urlArr.count; i++) {
                if ([urlArr[i] isEqualToString:@"action=back"]) {
                    [ProgressHUD dismiss];
                    [self.mainWebView removeFromSuperview];
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }
                
            }
        }
        return YES;
        
    }else if (self.versionA%3 == 1){
        NSLog(@"master除2的余数是1 %@",[[URLstring componentsSeparatedByString:@"?"] lastObject]);
        
        NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
        if ([request URL].query) {
            for (int i = 0; i < urlArr.count; i ++) {
                if ([urlArr[i] isEqualToString:@"action=back"]) {
                    [ProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if([urlArr[i] isEqualToString:@"action=open"]){
                    [ProgressHUD dismiss];
                    NSLog(@"我指跳了一次 %@",URLstring);
                    MasterViewController *assistantVC = [[MasterViewController alloc]init];
                    assistantVC.urlString = URLstring;
                    [self.navigationController pushViewController:assistantVC animated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=home"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 0;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=earning"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 1;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=yangche"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 2;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=wallet"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 3;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }
            }
            
        }
        return NO;
    }else if (self.versionA%3 == 0){
        NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
        if ([request URL].query) {
            for (int i = 0; i < urlArr.count; i++) {
                if ([urlArr[i] isEqualToString:@"action=back"]) {
                    [ProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if([urlArr[i] isEqualToString:@"action=open"]){
                    [ProgressHUD dismiss];
                    NSLog(@"我指跳了一次 %@",URLstring);
                    MasterViewController *assistantVC = [[MasterViewController alloc]init];
                    assistantVC.urlString = URLstring;
                    [self.navigationController pushViewController:assistantVC animated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=home"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 0;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=earning"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 1;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=yangche"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 2;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }else if ([urlArr[i] isEqualToString:@"target=wallet"]){
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 3;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                }
                
            }
        }
    }
    

    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}
@end
