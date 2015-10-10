//
//  MasterViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/7/14.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "MasterViewController.h"
#import "AssistantViewController.h"
#import "DeviceSelect.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"

@interface MasterViewController ()<UIWebViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
//{
//    CustomTabBar* tabBar;
//}
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) UIView *placeView;
@property (nonatomic, strong) UIScreen *myScreen;
@property (nonatomic, strong) UITabBar *tabbar;


@property NSMutableArray *objects;
@end

@implementation MasterViewController

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
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:bgView];
    
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
    NSString *URLString = [[request URL] absoluteString];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@   %@",self.urlString,URLString);
    // 长按点击  事件
//    if ([URLString isEqualToString:@"http://qianbao.ebaoyang.com/h5/index?clipboard=http://dwz.cn/1IIn6l"]){
//        [ProgressHUD dismiss];
//        
//        NSString *str = [[URLString  componentsSeparatedByString:@"?"] lastObject] ;
//        NSString *lastString = [[str   componentsSeparatedByString:@"="] lastObject] ;
//        UIPasteboard *pastBoard = [UIPasteboard generalPasteboard] ;
//        pastBoard.string = lastString ;
//        NSLog(@"%@",lastString) ;
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"链接已复制至剪切板" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] ;
//        [alert show] ;
    
        if ([[[[request URL].query componentsSeparatedByString:@"="] firstObject]isEqualToString:@"clipboard"]) {
            [ProgressHUD dismiss];
            
            NSString *str = [[URLString  componentsSeparatedByString:@"?"] lastObject] ;
            NSString *lastString = [[str   componentsSeparatedByString:@"="] lastObject] ;
            UIPasteboard *pastBoard = [UIPasteboard generalPasteboard] ;
            pastBoard.string = lastString ;
            NSLog(@"%@",lastString) ;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"链接已复制至剪切板" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] ;
            [alert show];
            return NO;
        }
//        
//        return NO;
//    }
    
    if ([URLString isEqualToString:self.urlString]) {
        return YES;
    }else{
        NSArray *urlArr = [[request URL].query componentsSeparatedByString:@"&"];
                if ([request URL].query) {
                    for (int i = 0; i < urlArr.count; i ++) {
                        if ([urlArr[i] isEqualToString:@"action=back"]) {
                            [ProgressHUD dismiss];
                            [self.navigationController popViewControllerAnimated:YES];
                            return NO;
                        }else if([urlArr[i] isEqualToString:@"action=open"]){
                            [ProgressHUD dismiss];
                            MasterViewController *masterVC = [[MasterViewController alloc]init];
                            masterVC.urlString = URLString;
                            [self.navigationController pushViewController:masterVC animated:YES];
                            return NO;
                        }else if ([urlArr[i] isEqualToString:@"target=home"]){
                            [ProgressHUD dismiss];
                            self.hidesBottomBarWhenPushed = NO;
                            appDelegate.tabBarController.selectedIndex = 0;
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            return NO;
                        }else if ([urlArr[i] isEqualToString:@"target=earning"]){
                            [ProgressHUD dismiss];
                            self.hidesBottomBarWhenPushed = NO;
                            appDelegate.tabBarController.selectedIndex = 1;
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            return NO;
                        }else if ([urlArr[i] isEqualToString:@"target=yangche"]){
                            [ProgressHUD dismiss];
                            self.hidesBottomBarWhenPushed = NO;
                            appDelegate.tabBarController.selectedIndex = 2;
                            [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    if ([[[URLString componentsSeparatedByString:@"?"] firstObject]isEqualToString:@"eby://share"]){
        [ProgressHUD dismiss];
        self.huaiData = [[URLString componentsSeparatedByString:@"?"] lastObject];
        [self selector];
        return NO;
    }
    return YES;
}
- (void)selector
{
    UIActionSheet *showAct = [[UIActionSheet alloc]initWithTitle:@"微信分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到朋友圈",@"分享给朋友", nil];
    //    showAct.
    [showAct showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self onSelectTimelineScene];
        if (_delegate) {
            [_delegate sendTextContent:self.huaiData];
        }
    }else if (buttonIndex == 1){
        [self onSelectSessionScene];
        NSLog(@"%@",self.huaiData);
        if (_delegate) {
            [_delegate sendTextContent:self.huaiData];
    }
    }else{
        
    }
  
}
- (void)onSelectSessionScene//会话
{
    [_delegate changeScene:WXSceneSession];
}
- (void)onSelectTimelineScene//朋友圈
{
    [_delegate changeScene:WXSceneTimeline];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
