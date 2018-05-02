//
//  RYPopMenuView.m
//  RYOptionPopMenu
//
//  Created by ryokaChen on 2018/4/25.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import "RYPopMenuView.h"

#define kPopMenuViewListHeight 44

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RYPopMenuView ()<UITableViewDataSource, UITableViewDelegate>
/** 蒙版 */
@property (nonatomic, weak) UIView *backGroundView;
/** 列表 */
@property (nonatomic, weak) UITableView *menuView;
/** 数据源 */
@property (nonatomic, strong) NSArray *dataSource;
/** 点击回调的block */
@property (nonatomic, copy)  void(^clickBlock)(NSIndexPath *indexPath);
/** 默认选中的cell */
@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation RYPopMenuView

#pragma mark - setup
- (instancetype)init
{
    if (self = [super init]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    // 背景
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = UIColorFromRGB(0x000000);
    backGroundView.alpha = 0.08;
    [self addSubview:backGroundView];
    _backGroundView = backGroundView;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [self.backGroundView addGestureRecognizer:ges];
    
    // 显示
    UITableView *menuView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    menuView.scrollEnabled = NO;
    menuView.delegate = self;
    menuView.dataSource = self;
    menuView.backgroundColor = UIColorFromRGB(0xffffff);
    [self addSubview:menuView];
    _menuView = menuView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _backGroundView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identStr = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identStr];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identStr];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = UIColorFromRGB(0xDCDCDC);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    if (indexPath.row == 0) {
        NSMutableAttributedString *textL = [[NSMutableAttributedString alloc] initWithString:@"Click"];
        //设置字体大小
        [textL addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0] range:NSMakeRange(0, 5)];
        //设置字体颜色
        [textL addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(0, 5)];
    
        cell.textLabel.attributedText = textL;
    }else{
        if (indexPath.row - 1 == self.selectedRow) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_select"]];
        }
        cell.textLabel.text = self.dataSource[indexPath.row-1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消原先的选中
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:self.selectedRow + 1 inSection:0];
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath1];
    cell1.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    tableView.userInteractionEnabled = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_select"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissCover:indexPath];
    });
}

#pragma mark - Action
- (void)show
{
    CGFloat menuHeight = kPopMenuViewListHeight * (self.dataSource.count + 1);
    CGFloat moveCount = self.bounds.size.height - menuHeight;
    CGRect moveR = (CGRect){{0, moveCount}, self.menuView.bounds.size};
    
    NSTimeInterval duration = 0.25;
    [UIView animateWithDuration:duration delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.menuView.frame = moveR;
    } completion:NULL];
}

- (void)dismissAction
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10000 inSection:0];
    [self dismissCover:indexPath];
}

- (void)dismissCover:(NSIndexPath *)indexPath
{
    CGRect moveR = (CGRect){{0, [UIScreen mainScreen].bounds.size.height}, self.menuView.bounds.size};
    
    NSTimeInterval duration = 0.25;
    [UIView animateWithDuration:duration delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.menuView.frame = moveR;
    } completion:^(BOOL finished) {
        if (self.clickBlock) {
            self.clickBlock(indexPath);
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - public
+ (instancetype)popMenuInView:(UIView *)view data:(NSArray *)data row:(NSInteger)row click:(void (^)(NSIndexPath *indexPath1))clickBlock
{
    RYPopMenuView *popView = [[RYPopMenuView alloc] init];
    popView.selectedRow = row;
    popView.clickBlock = clickBlock;
    popView.dataSource = data;
    popView.frame = view.bounds;
    [view addSubview:popView];
    
    // 菜单栏
    UITableView *menuView = popView.menuView;
    [menuView reloadData];
    CGFloat menuHeight = kPopMenuViewListHeight * (data.count + 1);
    menuView.frame = CGRectMake(0, popView.bounds.size.height, [UIScreen mainScreen].bounds.size.width, menuHeight);
    
    [popView show];
    
    return popView;
}

@end
