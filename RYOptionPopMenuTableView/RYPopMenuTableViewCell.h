//
//  RYPopMenuTableViewCell.h
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYPopMenuTableViewCell : UITableViewCell

/** 点击按钮 */
@property (strong,nonatomic) UIImageView *pressButton;

@property (strong,nonatomic) id model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 旋转角度 */
+ (void)startAnimation:(UIImageView *)view angle:(CGFloat)angle;

@end
