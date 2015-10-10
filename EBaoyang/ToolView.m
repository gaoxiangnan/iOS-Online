//
//  ToolView.m
//  HTML
//
//  Created by ebaoyang on 15/5/22.
//  Copyright (c) 2015年 ebaoyang. All rights reserved.
//

#import "ToolView.h"

@interface ToolView ()
@property (weak, nonatomic) IBOutlet UIButton *goInBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *goRefreshBtn;

@end

@implementation ToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    
}
+ (id)loadFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}
- (IBAction)onGoInBtn:(id)sender {
    if (_myInBlock) {
        _myInBlock();
    }
}
//- (IBAction)onGoBackBtn:(id)sender
//{
//    if (_myBackBlock) {
//        _myBackBlock();
//    }
//}
//- (IBAction)onGoRefreshBtn:(id)sender {
//    if (_myRefreshBlock) {
//        _myRefreshBlock();
//    }
//}





@end
