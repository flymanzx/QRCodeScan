//
//  ZXQRCodeScanController.h
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXQRCodeScanController : UIViewController

@property (nonatomic, copy) void (^QRCodeScanValueComplete)(NSString * QRCodeScanString);

@end

NS_ASSUME_NONNULL_END
