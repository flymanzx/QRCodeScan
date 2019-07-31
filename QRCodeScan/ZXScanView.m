//
//  ZXScanView.m
//  ZXQRCodeScanDemo
//
//  Created by 张鑫 on 2019/7/31.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ZXScanView.h"
@interface ZXScanView ()
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * flashlight;
@property (nonatomic, strong) UILabel * backHintLabel;
@property (nonatomic, strong) UILabel * flashlightHintLabel;
@end

@implementation ZXScanView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self updateUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.backButton];
    [self addSubview:self.backHintLabel];
    [self addSubview:self.flashlight];
    [self addSubview:self.flashlightHintLabel];
}

- (void)updateUI {
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.left.mas_offset(ScreenWidth/4 - 20);
        make.bottom.mas_offset(-100);
    }];
    
    [self.backHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_offset(30);
        make.left.mas_offset(ScreenWidth/4 - 30);
        make.bottom.mas_offset(-60);
    }];
    
    [self.flashlight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.left.mas_offset(ScreenWidth / 4 * 3 -20);
        make.bottom.mas_offset(-100);
    }];
    
    [self.flashlightHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_offset(30);
        make.left.mas_offset(ScreenWidth / 4 * 3 - 30);
        make.bottom.mas_offset(-60);
    }];
}

- (void)cancelAction {
    if (self.QRCodeScanBackComplete) {
        self.QRCodeScanBackComplete();
    }
}

- (void)flashlightAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"Flashlight_H"] forState:UIControlStateSelected];
        self.flashlightHintLabel.textColor =  [UIColor colorWithRed:133 / 255.f green:235 / 255.f blue:0 / 255.f alpha:1];
        if (self.QRCodeScanFlashLightComplete) {
            self.QRCodeScanFlashLightComplete(YES);
        }
    }else{
        [sender setImage:[UIImage imageNamed:@"Flashlight_N"] forState:UIControlStateSelected];
        self.flashlightHintLabel.textColor = [UIColor whiteColor];
        if (self.QRCodeScanFlashLightComplete) {
            self.QRCodeScanFlashLightComplete(NO);
        }
    }
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[[UIImage imageNamed:@"Down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)backHintLabel {
    if (!_backHintLabel) {
        _backHintLabel = [[UILabel alloc] init];
        _backHintLabel.text = @"返回";
        _backHintLabel.textAlignment = NSTextAlignmentCenter;
        _backHintLabel.textColor = [UIColor whiteColor];
    }
    return _backHintLabel;
}

- (UIButton *)flashlight {
    if (!_flashlight) {
        _flashlight = [[UIButton alloc] init];
        [_flashlight setImage:[UIImage imageNamed:@"Flashlight_N"] forState:UIControlStateNormal];
        [_flashlight addTarget:self action:@selector(flashlightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlight;
}

-(UILabel *)flashlightHintLabel {
    if (!_flashlightHintLabel) {
        _flashlightHintLabel = [[UILabel alloc] init];
        _flashlightHintLabel.text = @"手电筒";
        _flashlightHintLabel.textAlignment = NSTextAlignmentCenter;
        _flashlightHintLabel.textColor = [UIColor whiteColor];
    }
    return _flashlightHintLabel;
}


@end
