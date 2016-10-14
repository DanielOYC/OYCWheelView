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
    CGFloat _viewCenterXY;  //当前视图中心点XY
    CGFloat _viewWH; //当前视图的宽高
    CGFloat _centerBtnWH;  //中心按钮的宽高
    CGFloat _aroundButtonsW;  //周围图标按钮的宽度
    CGFloat _aroundButtonsH;  //周围图标按钮的高度
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
        
        _viewWH = self.frame.size.width;
        _viewCenterXY = _viewWH / 2;
        _centerBtnWH = _viewWH / 4;
        _aroundButtonsW = _centerBtnWH / 2;
        _aroundButtonsH = _aroundButtonsW + 20;
    
        //创建周围滚动的按钮
        [self setupAroundButtons];
        
        //创建中心按钮
        [self setupCenterButton];
    
    });
    
}

/**
 *  创建中心按钮
 */
-(void)setupCenterButton{
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerBtn addTarget:self action:@selector(hidesOrShow) forControlEvents:UIControlEventTouchUpInside];
    CGRect frame = centerBtn.frame;
    frame.size = CGSizeMake(_centerBtnWH, _centerBtnWH);
    centerBtn.frame = frame;
    centerBtn.center = CGPointMake(_viewCenterXY, _viewCenterXY);
    centerBtn.layer.cornerRadius = _centerBtnWH / 2;
    centerBtn.clipsToBounds = YES;
    centerBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:centerBtn];
}

/**
 *  创建周围滚动的按钮
 */
-(void)setupAroundButtons{
    
    CGFloat margin = _viewWH / (2 * 4);  //周围按钮与中间大按钮的间距
    CGFloat averageAngle = M_PI * 2 / self.titles.count;  //平分的角度
    CGFloat radius = margin + _centerBtnWH / 2 + _aroundButtonsH / 2;  //圆的半径
    
    for (NSInteger i = 0; i < self.titles.count; i++) {
        OYCVerticalButton *button = [OYCVerticalButton buttonWithType:UIButtonTypeCustom];
        CGFloat centerX = _viewCenterXY + sin(i * averageAngle) * radius;  //计算周围按钮的中心点坐标
        CGFloat centerY = _viewCenterXY - cos(i * averageAngle) * radius;
        button.frame = CGRectMake(0, 0, _aroundButtonsW, _aroundButtonsH);
        button.center = CGPointMake(centerX, centerY);
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buttons addObject:button];
        [self addSubview: button];
    }
}

/**
 *  让周围按钮影藏或显示
 */
-(void)hidesOrShow{
    if ([self.buttons[0] alpha] == 0.0) {
        for (OYCVerticalButton *button in self.buttons) {
            [UIView animateWithDuration:0.5 animations:^{
                button.alpha = 1.0;
                button.center = CGPointMake(button.lastCenterX, button.lastCenterY);
            }];
        }
    }else{
        for (OYCVerticalButton *button in self.buttons) {
            //先存储一下位置
            button.lastCenterX = button.center.x;
            button.lastCenterY = button.center.y;
            [UIView animateWithDuration:0.5 animations:^{
                button.alpha = 0.0;
                button.center = CGPointMake(_viewCenterXY, _viewCenterXY);
            }];
        }
    }
}

/**
 *  手指滑动处理
 */
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.buttons[0] alpha] == 0.0) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self]; //手指上一个触摸点
    CGPoint currentLocation = [touch locationInView:self]; //手指当前触摸点
    //滑动的两个点之间偏移的角度
    CGFloat deltaAngle = atan2f(fabs(currentLocation.x - _viewCenterXY), fabs(currentLocation.y - _viewCenterXY)) - atan2f(fabs(previousLocation.x - _viewCenterXY), fabs(previousLocation.y - _viewCenterXY));
    self.transform = CGAffineTransformRotate(self.transform, deltaAngle);
    
    //让所有周围按钮向相反方向旋转
    for (OYCVerticalButton *button in self.buttons) {
        button.transform = CGAffineTransformRotate(button.transform, -deltaAngle);
    }
    
    
}


@end
