//
//  ViewController.m
//  VideoCompressOutput
//
//  Created by Xinqi Chan on 14-5-26.
//  Copyright (c) 2014年 Xinqi Chan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImagePickerController+OrientationFix.h"
#import "UIViewController+OrientationFix.h"
#import "UIReviewViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){
    int pxIndex;
    NSArray *pxArray;
    int selectPxIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    selectPxIndex = 0;
    pxArray = @[@"High", @"Media", @"Low", @"640x480", @"960x540", @"1290x720"];
    [_pxBtn setTitle:[pxArray objectAtIndex:0] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)get:(id)sender {
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if (_segmentedController.selectedSegmentIndex == 0) {
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    imagePicker.mediaTypes = [NSArray arrayWithObjects:
                              (NSString *) kUTTypeMovie,
                              nil];
    imagePicker.allowsEditing = NO;
    
    switch (selectPxIndex) {
        case 0:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            break;
        }
        case 1:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeMedium];
            break;
        }
        case 2:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeLow];
            break;
        }
            
        case 3:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityType640x480];
            break;
        }
        case 4:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeIFrame960x540];
            break;
        }
        case 5:
        {
            [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeIFrame1280x720];
            break;
        }
        default:
            break;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (IBAction)choose:(id)sender {
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (int i=0, count = [pxArray count]; i < count; i++) {
        [ac addButtonWithTitle:[pxArray objectAtIndex:i]];
    }
    [ac showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    selectPxIndex =  buttonIndex;
    [_pxBtn setTitle:[pxArray objectAtIndex:selectPxIndex] forState:UIControlStateNormal];
}

#pragma mark - UIImagePickerControllerDelegate

//拍照完成代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
   NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [ mediaType isEqualToString:@"public.movie" ]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if (_segmentedController.selectedSegmentIndex == 0) {
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum ([videoURL path])) {
                UISaveVideoAtPathToSavedPhotosAlbum ([videoURL path] , nil, nil, nil);
            }
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        int kbLength = [self getFileSize:[videoURL path]];
        
        [_sizeLabel setText:[NSString stringWithFormat:@"%i kb", kbLength]];
        [_lengthLabel setText:[NSString stringWithFormat:@"%.2f", [self getVideoDuration:videoURL]]];
        
        _player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        _player.view.frame = CGRectMake(184, 100, 700, 400);
        [self.view addSubview:_player.view];
        [_player play];
    }
}

//取消代理

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//获取视频时间
- (CGFloat) getVideoDuration:(NSURL*) URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}


//获取视频 大小
- (NSInteger) getFileSize:(NSString*) path
{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }
    else
    {
        return -1;
    }
}

- (void)addOpBtnWith:(NSString *)name frame:(CGRect)frame action:(SEL)action
{
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    aBtn.frame = frame;
    [aBtn setTitle:name forState:UIControlStateNormal];
    [aBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
}


@end
