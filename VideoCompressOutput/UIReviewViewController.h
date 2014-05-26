//
//  UIReviewViewController.h
//  VideoCompressOutput
//
//  Created by Xinqi Chan on 14-5-26.
//  Copyright (c) 2014年 Xinqi Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIReviewViewController : UIImagePickerController{
}
@property(nonatomic, strong) NSString * length;
@property(nonatomic, strong) NSString * size;
@property(nonatomic, strong) NSURL * murl;
@end
