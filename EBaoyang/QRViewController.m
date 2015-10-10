//
//  QRViewController.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRViewController.h"
#import "DeviceSelect.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "QRresultViewController.h"
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@end

@implementation QRViewController
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
    
    CGFloat width = self.view.bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 64)];
    headView.backgroundColor = [DeviceSelect colorWithHexString:@"#393F4F"];
    [self.view addSubview:headView];
    
    UILabel * headLabel= [[UILabel alloc] initWithFrame:CGRectMake(50, 20, width-100, 50)];
    headLabel.textAlignment = NSTextAlignmentCenter;
//    headLabel.backgroundColor = [UIColor clearColor];
//    headLabel.font = [UIFont systemFontOfSize:22];
    headLabel.font = [UIFont systemFontOfSize:22];
    headLabel.textColor=[UIColor whiteColor];
    headLabel.text=@"扫一扫";
    [headView addSubview:headLabel];
    
    // Do any additional setup after loading the view.
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    //增加条形码扫描
//    _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
//                                    AVMetadataObjectTypeEAN8Code,
//                                    AVMetadataObjectTypeCode128Code,
//                                    AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    
    [_session startRunning];
    
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    QRView *qrRectView = [[QRView alloc] initWithFrame:screenRect];
    qrRectView.transparentArea = CGSizeMake(200, 200);
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    qrRectView.delegate = self;
    [self.view addSubview:qrRectView];
    
    
    
    UIButton *pop = [UIButton buttonWithType:UIButtonTypeCustom];
    pop.frame = CGRectMake(0, 20, 95, 50);
    pop.titleLabel.font    = [UIFont systemFontOfSize: 18];
    [pop setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    pop.imageEdgeInsets = UIEdgeInsetsMake(17, 14, 16, 20);
    [pop setTitle:@"返回" forState:UIControlStateNormal];
    [pop addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pop];
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                 (screenHeight - qrRectView.transparentArea.height) / 2,
                                 qrRectView.transparentArea.width,
                                 qrRectView.transparentArea.height);

    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                                                         ((screenHeight - qrRectView.transparentArea.height) / 2+qrRectView.transparentArea.height),
                                                                         qrRectView.transparentArea.width,
                                                                         50)];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，即可自动扫描。";
    [self.view addSubview:labIntroudction];
    
    UILabel * labIntroudction1= [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                                                         screenHeight-50,
                                                                         qrRectView.transparentArea.width,
                                                                         50)];
    labIntroudction1.textAlignment = NSTextAlignmentCenter;
    labIntroudction1.backgroundColor = [UIColor clearColor];
    labIntroudction1.numberOfLines=2;
    labIntroudction1.font = [UIFont systemFontOfSize:30];
    labIntroudction1.textColor=[UIColor whiteColor];
    labIntroudction1.text=@"养车钱包";
    [self.view addSubview:labIntroudction1];


}

- (void)pop:(UIButton *)button {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark QRViewDelegate
-(void)scanTypeConfig:(QRItem *)item {
    
    if (item.type == QRItemTypeQRCode) {
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    } else if (item.type == QRItemTypeOther) {
        
        _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode];
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"http://123.57.6.119:6779/pay/qr?data=%@",stringValue] forKey:@"GETDATA"];
    NSLog(@"我成功了 %@",stringValue);
    
    if (self.qrUrlBlock) {
        self.qrUrlBlock(stringValue);
    }
    QRresultViewController *resultVc = [[QRresultViewController alloc]init] ;
    resultVc.urlString = stringValue ;
    [self.navigationController  pushViewController:resultVc animated:YES];
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
