//
//  OYCVerticalButton.h
//  OYCWheelView
//
//  Created by cao on 16/10/13.
//  Copyright © 2016年 OYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYCVerticalButton : UIButton

//存储影藏前的中心点X,Y
@property(nonatomic,assign)CGFloat lastCenterX;
@property(nonatomic,assign)CGFloat lastCenterY;

@end
