//
//  HomeViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/6.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "FCUUID.h"
#import <AdSupport/AdSupport.h>
#import "ProgressHUD.h"
#import "MasterViewController.h"
#import "GXNAleartView.h"
#import "JSONKit.h"

@interface HomeViewController ()<UIWebViewDelegate,UIActionSheetDelegate,MasterViewControllerDelegate>
@property (nonatomic, strong)NSMutableData *receiveData;
@property (nonatomic, strong)NSString *storeStr;
@end

@implementation HomeViewController
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.receiveData = [[NSMutableData alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.myBlock = ^(){
        [self checkUpDate];
    
    };
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    self.navigationController.navigationBar.hidden = YES;
    
    NSString *cookieString = [NSString stringWithFormat:@";device_id=%@;device_type=iOS",[FCUUID uuidForDevice]];
    
    // 定義 cookie 要設定的 host
    NSURL *cookieHost = [NSURL URLWithString:INTERURL];
//    NSURL *cookieHost = [NSURL URLWithString:@"http://blog.toright.com:80/"];

    
    // 設定 cookie
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @".ebaoyang.com", NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             @"COOKIE_NAME",  NSHTTPCookieName,
                             cookieString, NSHTTPCookieValue,
//                             [[NSDate date] dateByAddingTimeInterval:2629743],NSHTTPCookieExpires,
                             
                             nil]];
    
    // 設定 cookie 到 storage 中
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    [self deleteCookie];
    
    [self updateSome];
    
    // 建立 NSURLRequest 連到 cookie.php，連線的時候會自動加入上面設定的 Cookie
    NSURL *urlAddress = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/index",INTERURL]];

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:urlAddress];
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.webView.delegate = self;



    NSHTTPCookieStorage *cookieJars = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJars cookies]) {
//        [cookieJars deleteCookie: cookie];
        NSLog(@"cookie is %@", cookie);
    }

    
    [self.webView loadRequest:requestObj];
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
    [ProgressHUD show:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"%@",requestString);
    
    NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
    NSLog(@"%@",urlArr);
    if ([request URL].query) {
        for (int i = 0; i < urlArr.count; i++) {
            if ([urlArr[i] isEqualToString:@"action=open"]) {
                [ProgressHUD dismiss];
                MasterViewController *masterVC = [[MasterViewController alloc]init];
                masterVC.delegate = self;
                masterVC.urlString = requestString;
                [self.navigationController pushViewController:masterVC animated:YES];
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
    
    NSLog(@"requestString is %@",requestString);
    
    
//    if ([requestString isEqualToString:@"http://qianbao.ebaoyang.com/h5/earning"]) {
//        [ProgressHUD dismiss];
//        appDelegate.tabBarController.selectedIndex = 1;
//        return NO;
//    }else if ([requestString isEqualToString:@"http://qianbao.ebaoyang.com/h5/yangche"]){
//        [ProgressHUD dismiss];
//        appDelegate.tabBarController.selectedIndex = 2;
//        return NO;
//    }
//    
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}

- (void)updateSome
{
    
    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *urlString = @"http://www.ebaoyang.com/app/activate/activate";
    NSURL *ulr = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:ulr cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = @"POST";
    NSString *param=[NSString stringWithFormat:@"appId=1&deviceType=IOS&plateformType=%@&deviceId=%@&idfa=%@",[NSString stringWithFormat:@"%@ %@",[DeviceSelect getDeviceId],[DeviceSelect getIOSVersion]],[FCUUID uuidForDevice],IDFA];
    NSLog(@"%@",param);
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    
        NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    
}
- (void)updateViews
{
//    NSURL *url1 = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/h5/index"];
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@h5/index",INTERURL]];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    [self.webView loadRequest:request1];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);//系统默认不支持旋转功能
}
- (void)checkUpDate// 写成异步
{
    NSString *urlString = @"http://www.ebaoyang.cn/app/download/checkUpdate/1";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",data);
    
    [self.receiveData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *recivedDic = [self.receiveData objectFromJSONData];
    
    
    
    if ([[[recivedDic objectForKey:@"data"] objectForKey:@"version"] intValue] == 1) {
        if ([[[recivedDic objectForKey:@"data"] objectForKey:@"updateForce"] intValue] == 0) {
            return;
        }else if ([[[recivedDic objectForKey:@"data"] objectForKey:@"updateForce"] intValue] == 1){
            UIAlertView *alrrtView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您使用的版本已经陈旧，请到appstore下载新的安装包" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alrrtView.tag = 10001;
            [alrrtView show];
            self.storeStr = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",@"1035499667"];
        }else{
            self.storeStr = [[recivedDic objectForKey:@"data"] objectForKey:@"resourceUrl"];
            
            UIAlertView *alrrtView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您使用的版本已经陈旧，请到指定页面下载新的安装包" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alrrtView.tag = 10000;
            [alrrtView show];
        }
    }
    
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
