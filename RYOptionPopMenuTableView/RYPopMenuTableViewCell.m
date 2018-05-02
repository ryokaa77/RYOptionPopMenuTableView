//
//  RYPopMenuTableViewCell.m
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import "RYPopMenuTableViewCell.h"
#import "RYPopMenuEachItemModel.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RYPopMenuTableViewCell ()
/** 主标题 **/
@property (nonatomic, strong) UILabel *typeLabel;
/** 副标题 **/
@property (nonatomic, strong) UILabel *resultLabel;
/** 分割线 **/
@property (nonatomic, strong) UIView *lineView;

@end
@implementation RYPopMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.font = [UIFont systemFontOfSize:16.0];
        typeLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:typeLabel];
        self.typeLabel = typeLabel;
        
        UILabel *resultLabel = [[UILabel alloc] init];
        resultLabel.textColor = [UIColor whiteColor];
        resultLabel.font = [UIFont systemFontOfSize:15.0];
        resultLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:resultLabel];
        self.resultLabel = resultLabel;
        
        UIImageView *pressButton = [[UIImageView alloc] init];
        pressButton.image = [UIImage imageNamed:@"icon_arrow"];
        [self.contentView addSubview:pressButton];
        self.pressButton = pressButton;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat separaterHeight = 0.5; //底部分割线高度
    CGFloat margin = 12;
    //标题
    self.typeLabel.frame = CGRectMake(margin, 0 ,90, self.frame.size.height);
    
    CGFloat labelX = CGRectGetMaxX(self.typeLabel.frame) + margin;
    self.resultLabel.frame = CGRectMake(labelX, 0, 160, self.frame.size.height);
    CGFloat labelX1 = CGRectGetMaxX(self.resultLabel.frame) + margin;
    //图片 customImageView
    UIImage *img =[UIImage imageNamed:@"icon_arrow"];
    self.pressButton.frame = CGRectMake(labelX1,CGRectGetHeight(self.resultLabel.frame)*0.5-2, img.size.width, img.size.height);
    //分割线
    self.lineView.frame = CGRectMake(0, self.frame.size.height - separaterHeight, self.frame.size.width, separaterHeight);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"CellIdentifier";
    RYPopMenuTableViewCell *cell = (RYPopMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[RYPopMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:0.188  green:0.188  blue:0.188 alpha:1];
        //设置cell选中时候透明效果
        //        UIView *selectedView = [[UIView alloc] init];
        //        selectedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        //        cell.selectedBackgroundView = selectedView;
    }
    return (RYPopMenuTableViewCell *)cell;
}

- (void)setModel:(id)model
{
    _model = model;
    
    RYPopMenuEachItemModel *itemM = (RYPopMenuEachItemModel *)model;
    
    self.typeLabel.text = itemM.itemTitle;
    self.resultLabel.text = itemM.detailItemTitle;
    if (itemM.iconItem.length > 0) {
        self.pressButton.image = [UIImage imageNamed:itemM.iconItem];
    }
}

+ (void)startAnimation:(UIImageView *)view angle:(CGFloat)angle {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            view.transform = CGAffineTransformMakeRotation(angle);
        } completion:nil];
    });
}

@end
