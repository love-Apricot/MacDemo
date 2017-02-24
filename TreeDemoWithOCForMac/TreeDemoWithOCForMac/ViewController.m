//
//  ViewController.m
//  TreeDemoWithOCForMac
//
//  Created by Apricot on 2017/2/23.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "ViewController.h"
#import "MyModel.h"

#define CellIdentifier @"CellIdentifier"

@interface ViewController ()<NSOutlineViewDelegate,NSOutlineViewDataSource>
@property (weak) IBOutlet NSOutlineView *outLineView;

@property (strong) MyModel *rootModel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self data];
    self.outLineView.dataSource = self;
    self.outLineView.delegate = self;
    
}

/**
 配置数据
 */
- (void)data{
    if(self.rootModel){
        return;
    }
    MyModel *rootModel = [[MyModel alloc] init];
    rootModel.name = @"root";
    rootModel.isGroup = YES;
    self.rootModel = rootModel;
    
    NSMutableArray *rootArray = [NSMutableArray array];
    rootModel.list = rootArray;
    
    MyModel *group1Model = [[MyModel alloc] init];
    group1Model.name = @"Group1";
    group1Model.isGroup = YES;
    [rootArray addObject:group1Model];
    
    NSMutableArray *group1Array = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        MyModel *group1Model = [[MyModel alloc] init];
        group1Model.name = [NSString stringWithFormat:@"Group1-%d",i];
        [group1Array addObject:group1Model];
    }
    MyModel *group1SubGroup1Model = [[MyModel alloc] init];
    group1SubGroup1Model.name = [NSString stringWithFormat:@"Group1SubGroup"];
    group1SubGroup1Model.isGroup = YES;
    [group1Array addObject:group1SubGroup1Model];
    NSMutableArray *group1SubGroupArray = [NSMutableArray array];

    for (int i = 0; i < 3; i++) {
        MyModel *group1Model = [[MyModel alloc] init];
        group1Model.name = [NSString stringWithFormat:@"SubGroup1-%d",i];
        [group1SubGroupArray addObject:group1Model];
    }
    group1SubGroup1Model.list =group1SubGroupArray;
    
    group1Model.list = group1Array;
    
    MyModel *group2Model = [[MyModel alloc] init];
    group2Model.name = @"Name2";
    group2Model.isGroup = NO;
    [rootArray addObject:group2Model];
    
}

- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item{
    NSTableCellView *view;

    if(item){
        MyModel *model = item;
        view = [outlineView  makeViewWithIdentifier:CellIdentifier owner:self];
        view.textField.stringValue = [NSString stringWithFormat:@"%@",model.name];
        view.textField.textColor = [NSColor redColor];
    }
    

    return view;
}


- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
    if(item){
        MyModel *model = item;
        if(model.isGroup){
            return [model.list count];
        }
    }
    return [self.rootModel.list count];
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
    if(item){
        MyModel *model = item;
        if(model.isGroup){
           return model.list[index];
        }
    }
    return self.rootModel.list[index];
}

- (BOOL) outlineView:(NSOutlineView *)outlineView isItemExpandable:(nonnull id)item{
    if(item){
        MyModel *model = item;
        if(model.isGroup){
            return YES;
        }
    }
    return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    NSLog(@"%@",item);
    //提供Staff的名字
    MyModel *model = item;

    return model.name;
}


- (void)outlineViewSelectionDidChange:(NSNotification *)notification{
    //选中的cell
    NSOutlineView *outlineView = notification.object;
    NSInteger selectedRow =  outlineView.selectedRow;
    
    MyModel *model = [outlineView  itemAtRow:selectedRow];
    if(model){
        [model listData];
    }
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
