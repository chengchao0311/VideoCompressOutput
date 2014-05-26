//
//  UIImagePickerController+OrientationFix.m
//  LoanTransation
//
//  Created by Xinqi Chan on 14-3-18.
//  Copyright (c) 2014年 FormsSyntron. All rights reserved.
//

#import "UIImagePickerController+OrientationFix.h"

@implementation UIImagePickerController (OrientationFix)

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
