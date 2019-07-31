//
//  ZXQRCodeScanManager.h
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^QRCodeScanResultComplete)(NSString *scanResultString);

@interface ZXQRCodeScanManager : NSObject

@property (nonatomic, copy)QRCodeScanResultComplete QRCodeScanResultComplete;

@property (nonatomic, strong)UIView *scanView;

+ (instancetype)manager;
/**
 * @brief 开始扫描。
 */
- (void)startRuning;
/**
 * @brief 停止扫描。
 */
- (void)stopRuning;
/**
 * @brief 设置扫描区域。
 */
- (void)setScaningRect:(CGRect)scanRect ScanView:(UIView *)scanViwe;
/**
 * @brief 显示扫描页面。
 */
- (void)showLayer:(UIView *)viewController;
/**
 * @brief 打开闪光灯。
 */
- (void)openFlashLight;
/**
 * @brief 关闭闪光灯。
 */
- (void)closeFlashLight;

@end

NS_ASSUME_NONNULL_END
