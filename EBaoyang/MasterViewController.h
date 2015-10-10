//
//  MasterViewController.h
//  EBaoyang
//
//  Created by ebaoyang on 15/7/14.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewController.h"

@protocol MasterViewControllerDelegate <NSObject>

- (void) sendTextContent:(NSString *)huaiData;
- (void) changeScene:(NSInteger)scene;

@end

typedef  void (^textBlock)(NSString *);
@interface MasterViewController : UIViewController


@property (strong, nonatomic) NSString *urlString;
@property (nonatomic, strong) NSString *huaiData;
@property (nonatomic, assign) id<MasterViewControllerDelegate,NSObject> delegate;
@property (nonatomic, copy) textBlock myBlock;



@end

