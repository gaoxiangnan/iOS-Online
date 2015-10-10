//
//  XYGifImage.h
//  XYCore
//
//  Created by sunyuping on 13-8-31.
//  Copyright (c) 2013年 Xingyun.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYGifImage : UIImage

@property (nonatomic, readonly) NSTimeInterval *frameDurations;
@property (nonatomic, readonly) NSTimeInterval totalDuration;
@property (nonatomic, readonly) NSUInteger loopCount;

- (NSTimeInterval)frameDurationWithIndex:(NSInteger)index;
+ (UIImage *)imageNamed:(NSString *)name;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path;
@end
