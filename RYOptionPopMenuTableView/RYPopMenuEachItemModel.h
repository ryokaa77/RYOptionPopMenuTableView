//
//  RYPopMenuEachItemModel.h
//  RYOptionPopMenuTableView
//
//  Created by ryokaChen on 2018/4/28.
//  Copyright © 2018年 ryokaChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYPopMenuEachItemModel : NSObject
/** 主标题 **/
@property (nonatomic, copy) NSString *itemTitle;

/** 副标题 **/
@property (nonatomic, copy) NSString *detailItemTitle;

/** 数据列表 **/
@property (nonatomic, strong) NSArray *itemListArray;

/** 图片 **/
@property (nonatomic, copy) NSString *iconItem;

+(instancetype)RY_popMenuEachItemModelWithItemTitle:(NSString *)itemTitle detailItemTitle:(NSString *)detailItemTitle ItemListArray:(NSArray *)itemListArray;

+(instancetype)RY_popMenuEachItemModelWithItemTitle:(NSString *)itemTitle detailItemTitle:(NSString *)detailItemTitle ItemListArray:(NSArray *)itemListArray iconItem:(NSString *)iconItem;
@end
