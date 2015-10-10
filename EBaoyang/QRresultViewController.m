//
//  QRresultViewController.m
//  EBaoyang
//
//  Created by gongjunna on 15/9/17.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "QRresultViewController.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"
@interface QRresultViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) UIView *placeView;
@property (nonatomic, strong) UIScreen *myScreen;
@end

@implementation QRresultViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
        
        
    
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.myScreen = [UIScreen mainScreen];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    
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
//
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = [[request URL] absoluteString];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@   %@",self.urlString,URLString);
    
    if ([URLString isEqualToString:self.urlString]) {
        return YES;
    }else{
        NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
        if ([request URL].query) {
            for (int i = 0; i < urlArr.count; i ++) {
                if ([urlArr[i] isEqualToString:@"action=back"]) {
                    [ProgressHUD dismiss];
//                    [self  dismissViewControllerAnimated:YES completion:nil] ;
                    [self.navigationController popViewControllerAnimated:YES];
                    return NO;
                
                }else if ([urlArr[i] isEqualToString:@"target=wallet"]){
                    
                    [ProgressHUD dismiss];
                    self.hidesBottomBarWhenPushed = NO;
                    appDelegate.tabBarController.selectedIndex = 3;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return NO;
                }
            }
        }
    }
    return YES;
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
