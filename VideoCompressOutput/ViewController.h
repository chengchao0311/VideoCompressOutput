//
//  ViewController.h
//  VideoCompressOutput
//
//  Created by Xinqi Chan on 14-5-26.
//  Copyright (c) 2014年 Xinqi Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
}
@property(strong, nonatomic) UIPopoverController * pop;
@property(strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIButton *pxBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
- (IBAction)get:(id)sender;
- (IBAction)choose:(id)sender;

@end
