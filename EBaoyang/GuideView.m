//
//  GuideView.m
//  EBaoyang
//
//  Created by ebaoyang on 15/9/16.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "GuideView.h"
#import "DeviceSelect.h"
@interface GuideView()
@end

@implementation GuideView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"%@",NSStringFromCGRect(frame));
//        NSString *iPhone5 = 
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(320*4, screenHeight);
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        
        NSArray *imageArr;
        
        NSString *iphone = [DeviceSelect getDeviceId];
        
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
                                                            imageView.image = [UIImage imageNamed:imageArr[i]];
                                                            [scrollView addSubview:imageView];
                                                            if (i == 2) {
                                                                UIButton* start = [UIButton buttonWithType:UIButtonTypeCustom];
                                                                start.alpha = 0;
                                                                start.layer.cornerRadius = 5;
                                                                start.layer.borderWidth = 0.5;
                                                                if ([iphone isEqualToString:@"iPhone5s"]||[iphone isEqualToString:@"iPhone5"]||[iphone isEqualToString:@"iPhone5c"]) {                                                                start.frame = CGRectMake(0, 0, 190, 45);
                                                                    [start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone5.png"] forState:UIControlStateNormal];
                                                                }else if ([iphone isEqualToString:@"iPhone6"]){
                                                                    start.frame = CGRectMake(0, 0, 230, 55);
                                                                    [start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone6.png"] forState:UIControlStateNormal];
                                                                }else if ([iphone isEqualToString:@"iPhone6Plus"]){
                                                                    start.frame = CGRectMake(0, 0, 240, 60);
                                                                    [start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone6p.png"] forState:UIControlStateNormal];
                                                                }else{
                                                                    start.frame = CGRectMake(0, 0, 190, 45);
                                                                    [start setBackgroundImage:[UIImage imageNamed:@"guideBtn_iphone4.png"] forState:UIControlStateNormal];
                                                                }
                                                                
                                                                [start setCenter:CGPointMake((i-1)*screenWidth+(screenWidth/2),400)];
                                                                [start setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                                                                [start addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
                                                                [start setTitle:@"Start" forState:UIControlStateNormal];
                                                                [scrollView addSubview:start];
                                                                
                                                                [UIView animateWithDuration:1 animations:^{
                                                                    start.alpha = 1;
                                                                } completion:^(BOOL finished) {
                                                                    
                                                                }];
                                                                
                                                                
                                                            }
        }
    }
    return self;
}
- (void)closeView
{
    
}
@end
