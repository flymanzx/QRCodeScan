//
//  ZXQRCodeScanController.m
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ZXQRCodeScanController.h"
#import "ZXMaskView.h"
#import "ZXQRCodeScanManager.h"
#import "ZXScanView.h"
@interface ZXQRCodeScanController ()
@property (nonatomic, strong) ZXMaskView * maskView;
@property (nonatomic, strong) ZXScanView *scanView;
@end

@implementation ZXQRCodeScanController

- (void)dealloc {
    [self.maskView removeAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ZXQRCodeScanManager manager] stopRuning];
    [[ZXQRCodeScanManager manager] closeFlashLight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scanQRCodeStart];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)scanQRCodeStart {
    UIView *scanView = [[UIView alloc] init];
    [[ZXQRCodeScanManager manager] showLayer:self.view];
    [[ZXQRCodeScanManager manager] setScaningRect:self.view.frame ScanView:scanView];
    weakSelfForBlock;
    [[ZXQRCodeScanManager manager] setQRCodeScanResultComplete:^(NSString * _Nonnull scanResultString) {
        NSLog(@"%@",scanResultString);
        [[ZXQRCodeScanManager manager] stopRuning];
        [wself processScanResultWithString:scanResultString];
    }];
    [[ZXQRCodeScanManager manager] startRuning];
}

- (void)createUI {
    self.maskView = [[ZXMaskView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.maskView];
    self.scanView = [[ZXScanView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.scanView];
    weakSelfForBlock;
    [self.scanView setQRCodeScanBackComplete:^{
        __strong typeof (wself) strongSelf = wself;
        [strongSelf cancelAction];
    }];
    [self.scanView setQRCodeScanFlashLightComplete:^(BOOL isOpenLight) {
        __strong typeof (wself) strongSelf = wself;
        [strongSelf isOpenOrCloseFlashLightWithStatus:isOpenLight];
    }];
}

- (void)processScanResultWithString:(NSString *)string {
    [[ZXQRCodeScanManager manager] closeFlashLight];
    if (self.QRCodeScanValueComplete) {
        self.QRCodeScanValueComplete(string);
        [[ZXQRCodeScanManager manager] stopRuning];
    }
    [self cancelAction];
}

- (void)cancelAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)isOpenOrCloseFlashLightWithStatus:(BOOL)status {
    if (status) {
        [[ZXQRCodeScanManager manager] openFlashLight];
    } else {
        [[ZXQRCodeScanManager manager] closeFlashLight];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
