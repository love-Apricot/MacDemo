//
//  MyModel.m
//  TreeDemoWithOCForMac
//
//  Created by Apricot on 2017/2/23.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel
- (void)listData{
    NSLog(@"所包含内容 %@",self.name);
    if([self.list count]>0){
        for (MyModel *subModel in self.list) {
            [subModel listData];
        }
    }
    
}
@end
