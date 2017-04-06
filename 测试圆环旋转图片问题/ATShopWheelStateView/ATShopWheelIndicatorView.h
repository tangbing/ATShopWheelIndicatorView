//
//  ATShopBlueWheelStateView.h
//  AetosTrade
//
//  Created by vst-wangxp on 15/11/24.
//  Copyright © 2015年 vst-Tb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class ATShopWheelIndicatorView;

@protocol ATShopWheelIndicatorViewDelegate <NSObject>

@optional
// 点击确定按钮的代理
- (void)wheelIndicatorStartBtn;
// 点击取消按钮的代理
- (void)wheelIndicatorCancelBtn;

@end

@interface ATShopWheelIndicatorView : UIView
@property (nonatomic,weak)id<ATShopWheelIndicatorViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *blueWheel_priceLabel;
/**产品名称*/
@property (weak, nonatomic) IBOutlet UILabel *blueWheel_symbolName;
/**多少手*/
@property (weak, nonatomic) IBOutlet UILabel *blueWheel_volume;
/*圆心背景图片*/
@property (weak, nonatomic) IBOutlet UIImageView *circImageviewBg;
/**圆环的宽度*/
@property (nonatomic, assign)CGFloat lineWidth;
- (void)setUp:(UIColor *)color;
- (void)show;
- (void)hide;
@end
