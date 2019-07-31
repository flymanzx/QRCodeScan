//
//  ZXMaskView.m
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ZXMaskView.h"
@interface ZXMaskView ()
@property (nonatomic, strong) UIImageView * scanLineImg;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UILabel * hintLabel;
@property (nonatomic, strong) UIImageView * topLeftImg;
@property (nonatomic, strong) UIImageView * topRightImg;
@property (nonatomic, strong) UIImageView * bottomLeftImg;
@property (nonatomic, strong) UIImageView * bottomRightImg;
@property (nonatomic, strong) UIBezierPath * bezier;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@property (nonatomic, assign) CGFloat isFirstTransition;  // 第一次旋转


@end
@implementation ZXMaskView

CGFloat const XYScanRatio = 0.68f;

- (void)commonInit{
    _isFirstTransition = YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self carateUI];
    }
    return self;
}

- (void)removeAnimation{
    [self.scanLineImg.layer removeAllAnimations];
}

- (void)resetFrame{
    UIImage * topLeft = [UIImage imageNamed:@"ScanQR1"];
    UIImage * topRight = [UIImage imageNamed:@"ScanQR2"];
    UIImage * bottomLeft = [UIImage imageNamed:@"ScanQR3"];
    UIImage * bottomRight = [UIImage imageNamed:@"ScanQR4"];
    UIImage * scanLine = [UIImage imageNamed:@"QRCodeScanLine"];
    [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    
    self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.width * XYScanRatio, 60);
    self.hintLabel.center = CGPointMake(self.maskView.center.x, 120);
    //左上
    self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, topLeft.size.width, topLeft.size.height);
    //右上
    self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5 - topRight.size.width + self.frame.size.width * XYScanRatio, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, topRight.size.width, topRight.size.height);
    //左下
    self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomLeft.size.height + self.frame.size.width * XYScanRatio, bottomLeft.size.width, bottomLeft.size.height);
    //右下
    self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * XYScanRatio, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * XYScanRatio, bottomRight.size.width, bottomRight.size.height);
    //扫描线
    self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, self.frame.size.width * XYScanRatio, scanLine.size.height);
}


- (void)carateUI {
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.3;
    self.maskView.layer.mask = [self maskLayer];
    [self addSubview:self.maskView];
    //提示框
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.text = @"将 二维码/条形码 放入框内中央，即可自动扫描";
    self.hintLabel.textColor = [UIColor colorWithRed:247 / 255.f green:247 / 255.f blue:247 / 255.f alpha:1];
    self.hintLabel.numberOfLines = 0;
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.hintLabel];
    //边框
    UIImage * topLeft = [UIImage imageNamed:@"ScanQR1"];
    UIImage * topRight = [UIImage imageNamed:@"ScanQR2"];
    UIImage * bottomLeft = [UIImage imageNamed:@"ScanQR3"];
    UIImage * bottomRight = [UIImage imageNamed:@"ScanQR4"];
    //左上
    self.topLeftImg = [[UIImageView alloc] init];
    self.topLeftImg.image = topLeft;
    [self addSubview:self.topLeftImg];
    //右上
    self.topRightImg = [[UIImageView alloc] init];
    self.topRightImg.image = topRight;
    [self addSubview:self.topRightImg];
    //左下
    self.bottomLeftImg = [[UIImageView alloc] init];
    self.bottomLeftImg.image = bottomLeft;
    [self addSubview:self.bottomLeftImg];
    //右下
    self.bottomRightImg = [[UIImageView alloc] init];
    self.bottomRightImg.image = bottomRight;
    [self addSubview:self.bottomRightImg];
    //扫描线
    UIImage * scanLine = [UIImage imageNamed:@"QRCodeScanLine"];
    self.scanLineImg = [[UIImageView alloc] init];
    self.scanLineImg.image = scanLine;
    self.scanLineImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.scanLineImg];
    [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.width * XYScanRatio, 60);
    self.hintLabel.center = CGPointMake(self.maskView.center.x, 120);
    //左上
    self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, topLeft.size.width, topLeft.size.height);
    //右上
    self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5 - topRight.size.width + self.frame.size.width * XYScanRatio, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, topRight.size.width, topRight.size.height);
    //左下
    self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomLeft.size.height + self.frame.size.width * XYScanRatio, bottomLeft.size.width, bottomLeft.size.height);
    //右下
    self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * XYScanRatio, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * XYScanRatio, bottomRight.size.width, bottomRight.size.height);
    //扫描线
    self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5 , (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, self.frame.size.width * XYScanRatio , scanLine.size.height);
}

- (CAShapeLayer *)maskLayer {
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [self maskPath].CGPath;
    return self.shapeLayer;
}


- (UIBezierPath *)maskPath {
    self.bezier = nil;
    self.bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (_isFirstTransition) {
        [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.width * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * XYScanRatio)) * 0.5, self.frame.size.width * XYScanRatio, self.frame.size.width * XYScanRatio)] bezierPathByReversingPath]];
    }else{
        [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.height * XYScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * XYScanRatio)) * 0.5, self.frame.size.height * XYScanRatio, self.frame.size.height * XYScanRatio)] bezierPathByReversingPath]];
    }
    return self.bezier;
}

- (CABasicAnimation *)animation {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    if (_isFirstTransition) {
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.center.y - self.frame.size.width * XYScanRatio * 0.5 + self.scanLineImg.image.size.height * 0.5))];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + self.frame.size.width * XYScanRatio * 0.5 - self.scanLineImg.image.size.height * 0.5)];
        _isFirstTransition = NO;
    }else{
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.frame.size.height - (self.frame.size.height * XYScanRatio)) * 0.5)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.scanLineImg.frame.origin.y + self.frame.size.height * XYScanRatio - self.scanLineImg.frame.size.height * 0.5)];
    }
    return animation;
}

@end
