//
//  ZXFlashLightManager.h
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXFlashLightManager : NSObject
/**
 * @brief 打开闪光灯。
 */
+ (void)openFlashLight;
/**
 * @brief 关闭闪光灯。
 */
+ (void)closeFlashLight;

@end

NS_ASSUME_NONNULL_END
