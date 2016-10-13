//
//  OYCWheelView.m
//  OYCWheelView
//
//  Created by cao on 16/10/7.
//  Copyright © 2016年 OYC. All rights reserved.
//

#import "OYCWheelView.h"
#import "OYCVerticalButton.h"

@interface OYCWheelView()
{
    CGFloat _viewCenterXY;
}

/**
 *  周围所有的按钮
 */
@property(nonatomic,strong)NSMutableArray *buttons;
@end

@implementation OYCWheelView

-(void)layoutSubviews{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self.buttons = [NSMutableArray array];
        
        CGFloat viewWH = self.frame.size.width;  //当前视图的宽高
        CGFloat centerXY = viewWH / 2;  //当前视图中心点XY
        _viewCenterXY = centerXY;
        CGFloat centerBtnWH = viewWH / 4;  //中心按钮的宽高
        CGFloat buttonsW = centerBtnWH / 2;  //周围图标按钮的宽度
        CGFloat buttonsH = buttonsW + 20;   //周围图标按钮的高度
        CGFloat margin = viewWH / (2 * 4);  //周围按钮与中间大按钮的间距
        CGFloat averageAngle = M_PI * 2 / self.titles.count;  //平分的角度
        CGFloat radius = margin + centerBtnWH / 2 + buttonsH / 2;
        
        //创建中心按钮
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerBtn addTarget:self action:@selector(hidesOrShow) forControlEvents:UIControlEventTouchUpInside];
        centerBtn.frame = CGRectMake(0, 0, centerBtnWH, centerBtnWH);
        centerBtn.center = CGPointMake(centerXY, centerXY);
        centerBtn.layer.cornerRadius = centerBtnWH / 2;
        centerBtn.clipsToBounds = YES;
        centerBtn.backgroundColor = [UIColor yellowColor];
        [self addSubview:centerBtn];
        
        
        //创建周围滚动的图标
        for (NSInteger i = 0; i < self.titles.count; i++) {
            OYCVerticalButton *button = [[OYCVerticalButton alloc]init];
            CGFloat centerX = centerXY + sin(i * averageAngle) * radius;
            CGFloat centerY = centerXY - cos(i * averageAngle) * radius;
            button.frame = CGRectMake(0, 0, buttonsW, buttonsH);
            button.center = CGPointMake(centerX, centerY);
            button.lastX = centerX;
            button.lastY = centerY;
            [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button.titleLabel sizeToFit];
            [self.buttons addObject:button];
            [self addSubview: button];
        }
        [self bringSubviewToFront:centerBtn];
    });
    
}

-(void)hidesOrShow{
    if ([self.buttons[0] center].x == _viewCenterXY && [self.buttons[0] center].y == _viewCenterXY) {
        for (OYCVerticalButton *button in self.buttons) {
            [UIView animateWithDuration:1.0 animations:^{
                button.alpha = 1.0;
                button.center = CGPointMake(button.lastX, button.lastY);
            }];
        }
    }else{
        for (OYCVerticalButton *button in self.buttons) {
            [UIView animateWithDuration:1.0 animations:^{
                button.alpha = 0.0;
                button.center = CGPointMake(_viewCenterXY, _viewCenterXY);
            }];
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.buttons[0] center].x == _viewCenterXY && [self.buttons[0] center].y == _viewCenterXY) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint currentLocation = [touch locationInView:self];
    CGFloat deltaAngle = atan2f(fabs(currentLocation.x - _viewCenterXY), fabs(currentLocation.y - _viewCenterXY)) - atan2f(fabs(previousLocation.x - _viewCenterXY), fabs(previousLocation.y - _viewCenterXY));
    self.transform = CGAffineTransformRotate(self.transform, deltaAngle);
    
    for (OYCVerticalButton *button in self.buttons) {
        button.transform = CGAffineTransformRotate(button.transform, -deltaAngle);
        button.lastX = button.center.x;
        button.lastY = button.center.y;
    }
    
    
}


@end
