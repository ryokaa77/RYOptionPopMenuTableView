//
//  RYDetailVC.m
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import "RYDetailVC.h"

@interface RYDetailVC ()

@end

@implementation RYDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"做人嘛,天天开心才对";
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_bg%d",arc4random() % 5]];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    bg.userInteractionEnabled = YES;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Follow Me" message:@"https://github.com/GiantAxe77" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *past = [UIPasteboard generalPasteboard];
        [past setString:@"https://github.com/GiantAxe77"];
        
    }];
    
    [alertVC addAction:act1];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}


@end
