//
//  ViewController.m
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import "ViewController.h"
#import "RYDetailVC.h"
#import "RYPopMenuView.h"
#import "RYPopMenuTableViewCell.h"
#import "RYPopMenuEachItemModel.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define kThemeColor [UIColor colorWithRed:0.188  green:0.188  blue:0.188 alpha:1];

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Have A Nice Work!";
    [self.view addSubview:self.tableView];
    
    [self initOriginData];
    
}

#pragma mark - initOriginData
- (void)initOriginData
{
    
    NSArray *dataArr1 = @[@"星期一",@"月曜日（げつようび）",@"월요일 (wo liao yir)",@"Lundi",@"Mon."];
    NSArray *dataArr2 = @[@"星期二",@"火曜日（かようび）",@"화요일 (hua yao yir)",@"mardi",@"Tue."];
    NSArray *dataArr3 = @[@"星期三",@"水曜日（すいようび）",@"수요일 (su yao yir)",@"mercredi",@"Wed."];
    NSArray *dataArr4 = @[@"星期四",@"木曜日（もくようび）",@"목요일 (mao giao yir)",@"jeudi",@"Thur."];
    NSArray *dataArr5 = @[@"星期五",@"金曜日（きんようび）",@"금요일 (gr miao yir)",@"vendredi",@"Fri."];
    NSArray *dataArr6 = @[@"星期六",@"土曜日 (どようび）",@"토요일 (tao yao yir)",@"samedi",@"Sat."];    
    NSArray *dataArr7 = @[@"星期日",@"日曜日（にちようび）",@"일요일 (yi liao yir)",@"dimanche",@"Sun."];
    
    RYPopMenuEachItemModel *model1 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Monday" detailItemTitle:@"Mon." ItemListArray:dataArr1];
    
    RYPopMenuEachItemModel *model2 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"TuesDay" detailItemTitle:@"Tue." ItemListArray:dataArr2];
    
    RYPopMenuEachItemModel *model3 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Wednesday" detailItemTitle:@"Wed." ItemListArray:dataArr3];
    
    RYPopMenuEachItemModel *model4 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Thursday" detailItemTitle:@"Thur." ItemListArray:dataArr4];
    
    RYPopMenuEachItemModel *model5 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Friday" detailItemTitle:@"Fri." ItemListArray:dataArr5];
    
    RYPopMenuEachItemModel *model6 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Saturday" detailItemTitle:@"Sat." ItemListArray:dataArr6];
    
    RYPopMenuEachItemModel *model7 = [RYPopMenuEachItemModel RY_popMenuEachItemModelWithItemTitle:@"Sunday" detailItemTitle:@"Sun." ItemListArray:dataArr7];
    
    NSArray *modelArr = @[model1,model2,model3,model4,model5,model6,model7];
    [self.dataSources addObjectsFromArray:modelArr];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RYPopMenuTableViewCell *cell = [RYPopMenuTableViewCell cellWithTableView:tableView];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RYPopMenuTableViewCell *cell = (RYPopMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [RYPopMenuTableViewCell startAnimation:cell.pressButton angle:M_PI];
    
    WEAKSELF;
    RYPopMenuEachItemModel *originModel =self.dataSources[indexPath.row];
    //对应的行数标记
    NSInteger row = 0;
    for (int i = 0; i < originModel.itemListArray.count; i++) {
        NSString *resultStr = originModel.itemListArray[i];
        if ([originModel.detailItemTitle isEqualToString:resultStr]) {
            row = i;
            break;
        }
    }
    
    [RYPopMenuView popMenuInView:self.view data:originModel.itemListArray row:row click:^(NSIndexPath *indexPath1) {
        
        [RYPopMenuTableViewCell startAnimation:cell.pressButton angle:0];
        if (indexPath1.row == 10000) {
        }
        else if (indexPath1.row == 0) {
            RYDetailVC *startV = [RYDetailVC new];
            [self.navigationController pushViewController:startV animated:YES];
            
        }else{
            NSString *temp = originModel.itemListArray[indexPath1.row - 1];
            originModel.detailItemTitle = temp;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kThemeColor;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}


@end
