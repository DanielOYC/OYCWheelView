//
//  OYCVerticalButton.m
//  OYCWheelView
//
//  Created by cao on 16/10/13.
//  Copyright © 2016年 OYC. All rights reserved.
//

#import "OYCVerticalButton.h"

@implementation OYCVerticalButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, 20);
}

@end
