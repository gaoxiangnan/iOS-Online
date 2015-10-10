//
//  SecondViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/9/2.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^guideBlock)();
@interface SecondViewController : UIViewController
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (copy,nonatomic)guideBlock myBlock;
@end
