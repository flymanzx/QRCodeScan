//
//  ZXScanView.h
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^QRCodeScanBackComplete)(void);

typedef void (^QRCodeScanOpenFlashLightComplete)(BOOL isOpenLight);

@interface ZXScanView : UIView
/**
 * @brief 返回点击complete。
 */
@property (nonatomic, copy)QRCodeScanBackComplete QRCodeScanBackComplete;
/**
 * @brief openflashLight，打开或者关闭闪光灯。
 */
@property (nonatomic, copy)QRCodeScanOpenFlashLightComplete QRCodeScanFlashLightComplete;
@end

NS_ASSUME_NONNULL_END
