//
//  ZXFlashLightManager.m
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ZXFlashLightManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZXFlashLightManager

+ (void)openFlashLight {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice unlockForConfiguration];
        }
    }
}

+ (void)closeFlashLight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

@end
