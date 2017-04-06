//
//  ATShopBlueWheelStateView.m
//  AetosTrade
//
//  Created by vst-wangxp on 15/11/24.
//  Copyright © 2015年 vst-Tb. All rights reserved.
//

// 2.获得RGB颜色
#define ATColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "ATShopWheelIndicatorView.h"


@interface ATShopWheelIndicatorView()
{
    CAShapeLayer *backGroundLayer; //背景图层
    CAShapeLayer *frontFillLayer;      //用来填充的图层
    UIBezierPath *backGroundBezierPath; //背景布赛尔曲线
    UIBezierPath *frontFillBezierPath;  //用来填充的布赛尔曲线
}

/**确定*/
@property (weak, nonatomic) IBOutlet UIButton *okButton;

/**背景遮盖*/
@property (nonatomic, strong) UIView *bgView;

@end

@implementation ATShopWheelIndicatorView

static CGFloat const animTimeInterval = 5;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ATShopWheelIndicatorView class]) owner:nil options:nil] firstObject];
        self.lineWidth = 6.0f;
        // 初始化设置
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = window.bounds;
        [window addSubview:self.bgView];
        [window addSubview:self];
    }
    return self;
}

- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

/**
 * 这里圆环动画的思路是：先利用UIBezierPath画一个圆形，然后画一个无色的背景圆环colorBackGroundLayer
   然后画一个滑动的圆环displayCircleLayer，然后做核心动画。
 */
- (void)setUp:(UIColor *)color
{
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:52 startAngle:0 endAngle:(2*M_PI) clockwise:NO];
    
    CAShapeLayer *colorBackGroundLayer = [CAShapeLayer layer];
    colorBackGroundLayer.path = frontFillBezierPath.CGPath;
    // 代表设置它的边框色
    colorBackGroundLayer.strokeColor = ATColor(230, 230, 230).CGColor;
    // 代表设置这个 Layer 的填充色
    colorBackGroundLayer.fillColor = [[UIColor clearColor] CGColor];
    colorBackGroundLayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:colorBackGroundLayer];
    
    
    CAShapeLayer *displayCircleLayer = [CAShapeLayer layer];
    displayCircleLayer.path = frontFillBezierPath.CGPath;
    // 滑动的圆环的颜色
    displayCircleLayer.strokeColor = color.CGColor;
    displayCircleLayer.fillColor = [[UIColor clearColor] CGColor];
    displayCircleLayer.lineWidth = self.lineWidth;
    
    [self.layer addSublayer:displayCircleLayer];
    [self drawLineAnimation:displayCircleLayer];
    
    
    //5s之后，按钮禁止点击
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.okButton.enabled = NO;
    });
    
}

- (void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = animTimeInterval;
    bas.delegate = self;
    bas.toValue = @(0);
    // 设置核心动画不反弹(下面两个个方法必须联合使用才有效)
    // 动画执行完毕之后不要删除动画
    bas.removedOnCompletion = NO;
    // 保持最新的状态
    bas.fillMode = kCAFillModeForwards;
    [layer addAnimation:bas forKey:nil];
}

/**取消*/
- (IBAction)blueWheel_cancelBtnClick:(id)sender
{
    [self hide];
    if ([self.delegate respondsToSelector:@selector(wheelIndicatorCancelBtn)]) {
        [_delegate wheelIndicatorCancelBtn];
    }
}

- (IBAction)blueWheel_okBtnClick:(id)sender
{
    [self hide];
    if ([self.delegate respondsToSelector:@selector(wheelIndicatorStartBtn)]) {
        [_delegate wheelIndicatorStartBtn];
    }
}

- (void)show
{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.hidden = NO;
    } completion:nil];
}

- (void)hide
{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        self.bgView.hidden = YES;
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
