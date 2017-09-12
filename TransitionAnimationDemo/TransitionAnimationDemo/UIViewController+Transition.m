//
//  UIViewController+Transition.m
//  TransitionAnimationDemo
//
//  Created by WDeng on 2017/9/11.
//  Copyright © 2017年 WDeng. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/runtime.h>


static const void *Transition_AniImg_Key = "Transition_AniImg_Key";
static const void *Transition_BgView_Key = "Transition_BgView_Key";
static const void *Transition_SouceFrame_Key = "Transition_SouceFrame_Key";



@implementation UIViewController (Transition)
 
- (UIImageView *)aniImgView {
    
    return objc_getAssociatedObject(self, Transition_AniImg_Key);
}

- (void)setAniImgView:(UIImageView *)aniImgView {
    objc_setAssociatedObject(self, Transition_AniImg_Key, aniImgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)transitionBgView {
    
    return objc_getAssociatedObject(self, Transition_BgView_Key);
}

- (void)setTransitionBgView:(UIImageView *)transitionBgView {
    objc_setAssociatedObject(self, Transition_BgView_Key, transitionBgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGRect)fromFrame {
    
    return [objc_getAssociatedObject(self , Transition_SouceFrame_Key) CGRectValue];
}

- (void)setFromFrame:(CGRect)fromFrame {
    NSValue *value = [NSValue valueWithCGRect:fromFrame];
    objc_setAssociatedObject(self, Transition_SouceFrame_Key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImage *)screenshot {
    UIView *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.frame.size, NO, 0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)presentDetailAnimationViewController:(UIViewController *)viewController  aniImgView:(UIImageView *)aniImgView toFrom:(CGRect)toFrame {
    // 截图为背景
    viewController.transitionBgView = [[UIImageView alloc] initWithImage:[self screenshot]];
    viewController.transitionBgView.frame = viewController.view.bounds;
    [viewController.view addSubview:viewController.transitionBgView];
    
    [self presentViewController:viewController animated:NO completion:^{
        
        UIView *window = [UIApplication sharedApplication].keyWindow;
        CGRect fromFrame = [aniImgView.superview convertRect:aniImgView.frame toView:window];
        
        viewController.aniImgView = [[UIImageView alloc] initWithImage:aniImgView.image];
        viewController.aniImgView.frame = fromFrame;
        [viewController.view addSubview:viewController.aniImgView];
        viewController.fromFrame = fromFrame;
        
        [UIView animateWithDuration:TransitionAni_Duration animations:^{
            viewController.aniImgView.frame = toFrame;
            viewController.transitionBgView.alpha = 0.0;
        }];
    
    }];
 
}

- (void)dismissDetailAnimationViewController {
    
    
    [UIView animateWithDuration:TransitionAni_Duration animations:^{
        self.transitionBgView.alpha = 1.0;
        self.aniImgView.frame = self.fromFrame;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil]; 
    }];
    

}

@end






