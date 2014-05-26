//
//  UIViewController+OrientationFix.m
//  LoanTransation
//
//  Created by Xinqi Chan on 14-3-18.
//  Copyright (c) 2014年 FormsSyntron. All rights reserved.
//  因为App只支持横屏 用来控制除了照相控件以外所有的ViewController都是横屏

#import "UIViewController+OrientationFix.h"

@implementation UIViewController (OrientationFix)


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
