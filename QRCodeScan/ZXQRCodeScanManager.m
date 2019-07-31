//
//  ZXQRCodeScanManager.m
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ZXQRCodeScanManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ZXFlashLightManager.h"

@interface ZXQRCodeScanManager ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession * session; // 输入输出的中间桥梁
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer; // 相机图层
@property (nonatomic, strong) NSMutableArray * metadataObjectTypes; //扫描支持的编码格式的数组
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) UIView *viewContainer;
@end

@implementation ZXQRCodeScanManager

+ (instancetype)manager {
    static ZXQRCodeScanManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZXQRCodeScanManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initScan];
    }
    return self;
}

- (void)initScan {
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    if (!TARGET_IPHONE_SIMULATOR) {
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [self.session addInput:_input];
        _output = [[AVCaptureMetadataOutput alloc] init];
        //设置代理 在主线程里刷新
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [self.session addOutput:_output];
        _output.metadataObjectTypes = self.metadataObjectTypes;
        self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
}

- (void)setScaningRect:(CGRect)scanRect ScanView:(UIView *)scanViwe {
    CGFloat x,y,width,height;
    x = scanRect.origin.y / _layer.frame.size.height;
    y = scanRect.origin.x / _layer.frame.size.width;
    width = scanRect.size.height / _layer.frame.size.height;
    height = scanRect.size.width /_layer.frame.size.width;
    _output.rectOfInterest = CGRectMake(x, y, width, height);
    self.scanView = scanViwe;
    if (self.scanView) {
        self.scanView.frame = scanRect;
        if (_viewContainer) {
            [_viewContainer addSubview:self.scanView];
        }
    }
}

- (void)showLayer:(UIView *)viewController {
    _viewContainer = viewController;
    _layer.frame = viewController.layer.frame;
    [_viewContainer.layer insertSublayer:_layer atIndex:0];
}

- (void)startRuning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session startRunning];
    }
}

- (void)stopRuning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session stopRunning];
    }
}

- (void)openFlashLight {
    [ZXFlashLightManager openFlashLight];
}

- (void)closeFlashLight {
    [ZXFlashLightManager closeFlashLight];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        if (self.QRCodeScanResultComplete) {
            self.QRCodeScanResultComplete(metadataObject.stringValue);
        }
    }
}

- (NSMutableArray *)metadataObjectTypes{
    if (!_metadataObjectTypes) {
        _metadataObjectTypes = [NSMutableArray arrayWithObjects:AVMetadataObjectTypeAztecCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode, nil];
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            [_metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code, AVMetadataObjectTypeITF14Code, AVMetadataObjectTypeDataMatrixCode]];
        }
    }
    return _metadataObjectTypes;
}

@end
