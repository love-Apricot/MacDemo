//
//  MyModel.h
//  TreeDemoWithOCForMac
//
//  Created by Apricot on 2017/2/23.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject


/**
 昵称
 */
@property (nonatomic, copy) NSString * name;

/**
 是否分组 YES 是分组 NO用户
 */
@property (nonatomic, assign) BOOL isGroup;


/**
 当isGroup为YES时生效，当前分组的数据
 */
@property (nonatomic, strong) NSMutableArray <MyModel *>* list;

/**
 列表数据
 */
- (void)listData;

@end
