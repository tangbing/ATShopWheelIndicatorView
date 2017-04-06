//
//  ViewController.m
//  测试圆环旋转图片问题
//
//  Created by mac on 16/8/29.
//  Copyright © 2016年 macTb. All rights reserved.
//

#import "ViewController.h"
#import "ATShopWheelIndicatorView.h"

@interface ViewController ()<ATShopWheelIndicatorViewDelegate>
@property (nonatomic,strong)ATShopWheelIndicatorView *indicatorView;

@end

@implementation ViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.indicatorView = [[ATShopWheelIndicatorView alloc] init];
    self.indicatorView.lineWidth = 10.0;
    [self.indicatorView show];
    self.indicatorView.delegate = self;
    [self.indicatorView setUp:[UIColor redColor]];
}

#pragma mark - ATShopWheelIndicatorViewDelegate
- (void)wheelIndicatorStartBtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"UIAlertControllerStyleAlert" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定按钮");
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)wheelIndicatorCancelBtn
{
    NSLog(@"wheelIndicatorCancelBtn");
}

@end
