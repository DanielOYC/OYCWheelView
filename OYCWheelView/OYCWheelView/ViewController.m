//
//  ViewController.m
//  OYCWheelView
//
//  Created by cao on 16/10/7.
//  Copyright © 2016年 OYC. All rights reserved.
//

#import "ViewController.h"
#import "OYCWheelView.h"

#define OYCScreenW [[UIScreen mainScreen] bounds].size.width
#define OYCScreenH [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

/**
 *  垂直按钮的标题数据
 */
@property(nonatomic,strong)NSMutableArray *titlesArray;
/**
 *  垂直按钮的图片数据
 */
@property(nonatomic,strong)NSMutableArray *imagesNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建数据源
    [self setupDataSources];
    
    //创建轮子视图
    [self setupWheelView];
}

/**
 *  创建数据源
 */
-(void)setupDataSources{
    NSArray *titles = @[@"抖动",@"神奇",@"弹性",@"翻页",@"扩散"];
    NSArray *imageNames = @[@"btn_increase",@"business_center_2",@"home_2",@"message_2",@"task_management_2"];
    self.titlesArray = [NSMutableArray arrayWithArray:titles];
    self.imagesNameArray = [NSMutableArray arrayWithArray:imageNames];
}

/**
 *  创建轮子视图
 */
-(void)setupWheelView{
    OYCWheelView *wheelView = [[OYCWheelView alloc]initWithFrame:CGRectMake(0, 0, OYCScreenW, OYCScreenW)];
    wheelView.titles = self.titlesArray;
    wheelView.images = self.imagesNameArray;
    wheelView.center = CGPointMake(OYCScreenW / 2, OYCScreenH / 2);
    [self.view addSubview:wheelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
