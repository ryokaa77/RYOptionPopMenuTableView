//
//  RYPopMenuEachItemModel.m
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import "RYPopMenuEachItemModel.h"

@implementation RYPopMenuEachItemModel
+(instancetype)RY_popMenuEachItemModelWithItemTitle:(NSString *)itemTitle detailItemTitle:(NSString *)detailItemTitle ItemListArray:(NSArray *)itemListArray
{
    return [self RY_popMenuEachItemModelWithItemTitle:itemTitle detailItemTitle:detailItemTitle ItemListArray:itemListArray iconItem:@"icon_arrow"];
}

+(instancetype)RY_popMenuEachItemModelWithItemTitle:(NSString *)itemTitle detailItemTitle:(NSString *)detailItemTitle ItemListArray:(NSArray *)itemListArray iconItem:(NSString *)iconItem
{
    RYPopMenuEachItemModel *model = [[RYPopMenuEachItemModel alloc] init];
    model.itemTitle = itemTitle;
    model.detailItemTitle = detailItemTitle;
    model.itemListArray = itemListArray;
    model.iconItem = iconItem;
    
    return model;
}
@end
