//
//  RYPopMenuView.h
//  RYOptionPopMenu
//
//  Created by ryokaChen on 2018/4/25.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYPopMenuView : UIView

//快速实例化一个菜单对象
+ (instancetype)popMenuInView:(UIView *)view data:(NSArray *)data row:(NSInteger)row click:(void (^)(NSIndexPath *indexPath))clickBlock;

@end
