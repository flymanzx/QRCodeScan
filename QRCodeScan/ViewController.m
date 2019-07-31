//
//  ViewController.m
//  QRCodeScan
//
//  Created by 张鑫 on 2019/8/1.
//  Copyright © 2019 张鑫. All rights reserved.
//

#import "ViewController.h"
#import "ZXQRCodeScanController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]  initWithFrame:CGRectMake(ScreenWidth/2 -100, 200, 200, 200)];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"开始扫描" forState:UIControlStateNormal];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
- (void) onClick {
    ZXQRCodeScanController *vc = [[ZXQRCodeScanController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    weakSelfForBlock;
    [vc setQRCodeScanValueComplete:^(NSString * _Nonnull QRCodeScanString) {
        StrongSelf;
        [strongSelf alertViewShowWithString:QRCodeScanString];
    }];
}
- (void)alertViewShowWithString:(NSString *)string {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alertview show];

}

@end
