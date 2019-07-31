//
//  ZXMaskView.h
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXMaskView : UIView

/**
 * @brief 重设UI的frame。
 */
- (void)resetFrame;

/**
 * @brief 移除动画。
 */
- (void)removeAnimation;

@end

NS_ASSUME_NONNULL_END
