//
//  OYCVerticalButton.m
//  OYCWheelView
//
//  Created by cao on 16/10/13.
//  Copyright © 2016年 OYC. All rights reserved.
//

#import "OYCVerticalButton.h"

@interface OYCVerticalButton()
{
    CGFloat _width;
    NSInteger _flag;
}
@end

@implementation OYCVerticalButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_flag == 0) {
        _width = self.frame.size.width;
        _flag = 1;
    }
    self.imageView.frame = CGRectMake(0, 0, _width, _width);
    self.titleLabel.frame = CGRectMake(0, _width, _width, 20);
}

@end
