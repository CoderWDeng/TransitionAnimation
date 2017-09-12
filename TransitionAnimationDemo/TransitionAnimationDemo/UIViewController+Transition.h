//
//  UIViewController+Transition.h
//  TransitionAnimationDemo
//
//  Created by WDeng on 2017/9/11.
//  Copyright © 2017年 WDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const TransitionAni_Duration = 0.75;

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface UIViewController (Transition)

@property (nonatomic,strong) UIImageView *aniImgView;  // 动画图片
@property (nonatomic,strong) UIImageView *transitionBgView; // 过渡背景图
@property (nonatomic,assign) CGRect fromFrame; // 原来的图片的frame 


- (void)presentDetailAnimationViewController:(UIViewController *)viewController aniImgView:(UIImageView *)aniImgView toFrom:(CGRect)toFrame;
- (void)dismissDetailAnimationViewController;

@end
