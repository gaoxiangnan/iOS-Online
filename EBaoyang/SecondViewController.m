//
//  SecondViewController.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/2.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "SecondViewController.h"
#import "WalletViewController.h"
#import "DeviceSelect.h"


@interface SecondViewController ()<UIScrollViewDelegate>
{
    UIButton* _start;
}
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(screenWidth*3, screenHeight);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    NSArray *imageArr;
    
    NSString *iphone = [DeviceSelect getDeviceId];
    NSLog(@"iphone is %@",iphone);
    
    if ([iphone isEqualToString:@"iPhone5s"]||[iphone isEqualToString:@"iPhone5"]||[iphone isEqualToString:@"iPhone5c"]) {
        imageArr = [NSArray arrayWithObjects:@"guide1_iphone5.png",@"guide2_iphone5.png",@"guide3_iphone5.png", nil];
    }else if ([iphone isEqualToString:@"iPhone6"]){
        imageArr = [NSArray arrayWithObjects:@"guide1_iphone6.png",@"guide2_iphone6.png",@"guide3_iphone6.png", nil];
    }else if ([iphone isEqualToString:@"iPhone6Plus"]){
        imageArr = [NSArray arrayWithObjects:@"guide1_iphone6p.png",@"guide2_iphone6p.png",@"guide3_iphone6p.png", nil];
    }else{
        imageArr = [NSArray arrayWithObjects:@"guide1_iphone4.png",@"guide2_iphone4.png",@"guide3_iphone4.png", nil];
    }
    
    
    for (int i=0; i<3; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, screenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i]];
        [scrollView addSubview:imageView];
        if (i == 2) {
            _start = [UIButton buttonWithType:UIButtonTypeCustom];
            _start.alpha = 0;
            if ([iphone isEqualToString:@"iPhone5s"]||[iphone isEqualToString:@"iPhone5"]||[iphone isEqualToString:@"iPhone5c"]) {                                                                _start.frame = CGRectMake(0, 0, 190, 45);
                [_start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone5.png"] forState:UIControlStateNormal];
            }else if ([iphone isEqualToString:@"iPhone6"]){
                _start.frame = CGRectMake(0, 0, 230, 55);
                [_start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone6.png"] forState:UIControlStateNormal];
            }else if ([iphone isEqualToString:@"iPhone6Plus"]){
                _start.frame = CGRectMake(0, 0, 240, 60);
                [_start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone6p.png"] forState:UIControlStateNormal];
            }else{
                _start.frame = CGRectMake(0, 0, 190, 45);
                [_start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone4.png"] forState:UIControlStateNormal];
            }
            
            [_start setCenter:CGPointMake((i)*screenWidth+(screenWidth/2),screenHeight - 80)];
//            [_start setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_start addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:_start];
            

            
            
            
        }
    
}

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x >= self.view.frame.size.width*2) {
        [UIView animateWithDuration:1 animations:^{
            _start.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    

}
- (void)closeView
{
    if (_myBlock) {
        _myBlock();
    }
}
- (void)didReceiveMemoryWarning
{
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
