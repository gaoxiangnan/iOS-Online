//
//  AppDelegate.m
//  EBaoyang
//
//  Created by ebaoyang on 15/7/14.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "JSONKit.h"
#import "BaseViewController.h"
#import "FCUUID.h"
#import "GuideView.h"
#import "SecondViewController.h"
#import "GXNAleartView.h"
#import "MasterViewController.h"
#import "Reachability.h"

@class WXApi;

@interface AppDelegate ()<UITabBarControllerDelegate,UIAlertViewDelegate,MasterViewControllerDelegate,WalletViewControllerDelegate,HomeViewControllerDelegate,NSURLConnectionDelegate>
@property (nonatomic,strong)NSMutableData *receiveData;

@end

@implementation AppDelegate

- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
   
    return self;
   
}
-(void) changeScenes:(NSInteger)scene
{
    _scene = scene;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.receiveData = [[NSMutableData alloc]init];
    [WXApi registerApp:@"wx9b6e764c557cec0b"];
    
    //当前系统版本
    self.versionInt = 1;
    
    
    self.splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    NSString *iphone = [DeviceSelect getDeviceId];
    if ([[DeviceSelect netReachability] isReachable] == YES) {//判断是否有网
        NSURL *url = [NSURL URLWithString:@"http://qianbao.ebaoyang.com/basic/switch/app_head_figure"];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([resultString isEqualToString:@"0"]) {
            [self selector];
        }else{
            if ([iphone isEqualToString:@"iPhone5s"]||[iphone isEqualToString:@"iPhone5"]||[iphone isEqualToString:@"iPhone5c"]) {
                [self.splashView setImage:[UIImage imageNamed:@"huanyin02.jpg"]];
            }else if ([iphone isEqualToString:@"iPhone6"]){
                [self.splashView setImage:[UIImage imageNamed:@"backimage_huanyin.png"]];
            }else if ([iphone isEqualToString:@"iPhone6Plus"]){
                [self.splashView setImage:[UIImage imageNamed:@"huanyin04.jpg"]];
            }else{
                [self.splashView setImage:[UIImage imageNamed:@"huanyin01.jpg"]];
            }
            [self performSelector:@selector(showWord) withObject:nil afterDelay:1.2f];
            [self.window addSubview:self.splashView];
            [self.window bringSubviewToFront:self.splashView];
        }
    }else{
        [self selector];
        
    }
    
    
    
    
    
    
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showWord
{
    [UIView animateKeyframesWithDuration:1.f delay:0.0f options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
                                  self.splashView.alpha = 1.0;
                              } completion:^(BOOL finished) {
                                  [NSThread sleepForTimeInterval:0.5f];
                                  [self.splashView removeFromSuperview];
                                  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                                  if(![userDefaults objectForKey:@"FirstLoad"]) {
                                      [userDefaults setBool:NO forKey:@"FirstLoad"];
                                      //显示引导页
                                      SecondViewController *secondVC = [[SecondViewController alloc]init];
                                      self.window.rootViewController = secondVC;
                                      secondVC.myBlock = ^(){
                                          [self selector];
                                      };
                                  }else{
                                      [self selector];
                                  }

                              }];
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
    

    
    if ([[[recivedDic objectForKey:@"data"] objectForKey:@"version"] intValue] == self.versionInt) {
        if ([[[recivedDic objectForKey:@"data"] objectForKey:@"updateForce"] intValue] == 0) {
            return;
        }else if ([[[recivedDic objectForKey:@"data"] objectForKey:@"updateForce"] intValue] == 1){
            UIAlertView *alrrtView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您使用的版本已经陈旧，请到appstore下载新的安装包" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alrrtView.tag = 10001;
            [alrrtView show];
            self.storeStr = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",@"1035499667"];
        }else{
            self.qiyeStr = [[recivedDic objectForKey:@"data"] objectForKey:@"resourceUrl"];
            
            UIAlertView *alrrtView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您使用的版本已经陈旧，请到指定页面下载新的安装包" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alrrtView.tag = 10000;
            [alrrtView show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *hhAlertView = (UIAlertView *)alertView;
    if (hhAlertView.tag == 10000) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.qiyeStr]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.storeStr]];
    }
    
}
- (void)selector
{
    self.homeVC = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
    self.homeVC.delegate = self;
    UINavigationController *navVC1 = [[UINavigationController alloc]initWithRootViewController:self.homeVC];

    UIImage *musicImage = [UIImage imageNamed:@"icon_homeselected.png"];
    UIImage *musicImageSel = [UIImage imageNamed:@"icon_homeunselected.png"];

    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:1];
    [item1 setFinishedSelectedImage:musicImage
        withFinishedUnselectedImage:musicImageSel];
    navVC1.tabBarItem = item1;
    self.homeVC.title = @"首页";


    self.earningVC = [[EarningViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navVC2 = [[UINavigationController alloc]initWithRootViewController:self.earningVC];
    
    UIImage *musicImage2 = [UIImage imageNamed:@"icon_moneyselected.png"];
    UIImage *musicImageSel2 = [UIImage imageNamed:@"icon_moneyunselected.png"];
    
    musicImage2 = [musicImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel2 = [musicImageSel2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:2];
    [item2 setFinishedSelectedImage:musicImage2
        withFinishedUnselectedImage:musicImageSel2];
    navVC2.tabBarItem = item2;
    self.earningVC.title = @"赚钱";

    self.yangcheVC = [[YangcheViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navVC3 = [[UINavigationController alloc]initWithRootViewController:self.yangcheVC];
//    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:2];
//    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"icon_makecarselected.png"]
//        withFinishedUnselectedImage:[UIImage imageNamed:@"icon_makecarunselected.png"]];
    
    UIImage *musicImage3 = [UIImage imageNamed:@"icon_makecarselected.png"];
    UIImage *musicImageSel3 = [UIImage imageNamed:@"icon_makecarunselected.png"];
    
    musicImage3 = [musicImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel3 = [musicImageSel3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:2];
    [item3 setFinishedSelectedImage:musicImage3
        withFinishedUnselectedImage:musicImageSel3];
    
    navVC3.tabBarItem = item3;
    self.yangcheVC.title = @"养车";


    self.walletVC = [[WalletViewController alloc] initWithNibName:nil bundle:nil];
    self.walletVC.delegate = self;
    UINavigationController *navVC4 = [[UINavigationController alloc]initWithRootViewController:self.walletVC];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:2];
    
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"icon_walletselected.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"icon_walletunselected.png"]];
    UIImage *musicImage4 = [UIImage imageNamed:@"icon_walletselected.png"];
    UIImage *musicImageSel4 = [UIImage imageNamed:@"icon_walletunselected.png"];
    
    musicImage4 = [musicImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel4 = [musicImageSel4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item4 setFinishedSelectedImage:musicImage4
        withFinishedUnselectedImage:musicImageSel4];
    navVC4.tabBarItem = item4;
    self.walletVC.title = @"钱包";
    


    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]
                                                        } forState:UIControlStateNormal];


    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.VCArray = [NSArray arrayWithObjects:navVC1, navVC2,navVC3,navVC4, nil];
    self.tabBarController.viewControllers = self.VCArray;
    self.window.rootViewController = self.tabBarController;
    


}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    BaseViewController *baseVC = (BaseViewController *)viewController;
//    [baseVC updateViews];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
//        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//        if (resp.errCode == 0) {
//            _strMsg = @"分享成功";
//        }else if (resp.errCode == -2){
//            _strMsg = @"取消分享";
//        }else {
//            _strMsg = @"分享失败";
//        }
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:_strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
        NSMutableString* cardStr = [[NSMutableString alloc] init];
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%u\n",cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self checkUpDate];
    if (_myBlock) {
        _myBlock();
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) sendTextContents:(NSString *)huaiString
{
    NSLog(@"%@",[huaiString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    
    
    
    NSString *nwString = [huaiString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *strArray = [nwString componentsSeparatedByString:@"&"];
    
    NSLog(@"%@ %@",[[strArray lastObject] substringFromIndex:8],[[strArray firstObject] substringFromIndex:4]);
    
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [[strArray lastObject] substringFromIndex:6];
    message.description = [strArray[1] substringFromIndex:8];
    [message setThumbImage:[UIImage imageNamed:@"weixin.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [[strArray firstObject] substringFromIndex:4];
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}

@end
