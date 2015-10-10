//
//  ToolView.h
//  HTML
//
//  Created by ebaoyang on 15/5/22.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void (^goBackBlock)();
typedef void (^goInBlock)();
//typedef void (^goRefeeshBlock)();

@interface ToolView : UIView

//@property (copy,nonatomic)goBackBlock myBackBlock;
@property (copy,nonatomic)goInBlock myInBlock;
//@property (copy,nonatomic)goRefeeshBlock myRefreshBlock;


+ (id)loadFromXib;
@end
