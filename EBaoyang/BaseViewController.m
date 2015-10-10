//
//  BaseViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/7.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "BaseViewController.h"
#import "DeviceSelect.h"
#import "ProgressHUD.h"

@interface BaseViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScreen *myScreen;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    
    self.myScreen = [UIScreen mainScreen];
    self.baseView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.myScreen.bounds.size.width, self.myScreen.bounds.size.height-20)];
    self.baseView.delegate = self;
    self.baseView.scrollView.delegate = self;
    
    //禁止UIWebView下拉拖动效果
    for(id subview in self.baseView.subviews){
        
        if([[subview class] isSubclassOfClass:[UIScrollView class]])
            
            ((UIScrollView *)subview).bounces = NO;
    }
    
    //After iOS 5
    self.baseView.scrollView.bounces = NO;
    [self.view addSubview:self.baseView];
    // Do any additional setup after loading the view.
}
- (void)setBaseURL:(NSURL *)baseURL
{
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    [self.baseView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [ProgressHUD show:nil];
    NSString *URLstring = [[request URL] absoluteString];
    NSLog(@"baseVC URLstring is %@",URLstring);
    if ([[[URLstring componentsSeparatedByString:@"?"] lastObject]isEqualToString:@"action=back&direction=right"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }

    
//    if ([[[URLstring componentsSeparatedByString:@"?"] lastObject]isEqualToString:@"action=open&direction=right"]){
//        
//        return [self willStartLoadWithRequest:request];
//    }
    
//
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
        [ProgressHUD dismiss];
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
