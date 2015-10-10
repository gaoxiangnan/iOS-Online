//
//  GXNAleartView.h
//  AddViewText
//
//  Created by xngao on 14-5-13.
//  Copyright (c) 2014年 xngao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^onVersionCancleBlock)();
typedef void (^onVersionSureBlock)();

@interface GXNAleartView : UIView

@property (nonatomic,assign) CGFloat dltime;


@property (copy, nonatomic) onVersionSureBlock versionSureBlock;
@property (copy, nonatomic) onVersionCancleBlock versionCancleBlock;




@property (weak, nonatomic) IBOutlet UIView *versionView;


+ (id)loadViewFromXibNamed;




+(void)GXNAleartWitVersionhView:(UIView *)views versionSure:(onVersionSureBlock)sureBlock cancleBlock:(onVersionCancleBlock)cancleBlock;

//- (void)shouInView:(UIView *)view sure:(onSureBlock)suerBlock;
@end
