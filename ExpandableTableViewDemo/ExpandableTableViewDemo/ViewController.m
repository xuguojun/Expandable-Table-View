//
//  ViewController.m
//  ExpandableTableViewDemo
//
//  Created by guojun on 9/21/15.
//  Copyright © 2015 guojunxu. All rights reserved.
//

#import "ViewController.h"
#import "GJExpandableTableView.h"
#import "GJSectionItem.h"
#import "GJRowItem.h"

@interface ViewController ()<GJExpandableTableViewDelegate>

@property (nonatomic, weak) IBOutlet GJExpandableTableView *expandableTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // fix bug: view is under status bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"Expandable Table View";
    
    self.expandableTableView.items = [self items];
}

- (NSArray *)items{
    GJRowItem *subItem1 = [GJRowItem new];
    subItem1.itemID = @1;
    subItem1.title = @"Class A";
    
    GJRowItem *subItem2 = [GJRowItem new];
    subItem2.itemID = @2;
    subItem2.title = @"Class B";
    
    GJRowItem *subItem3 = [GJRowItem new];
    subItem3.itemID = @3;
    subItem3.title = @"Class C";
    
    NSMutableArray *subItems = [[NSMutableArray alloc] initWithObjects:subItem1, subItem2, subItem3, nil];
    
    GJRowItem *subItem4 = [GJRowItem new];
    subItem4.itemID = @1;
    subItem4.title = @"Class A";
    
    GJRowItem *subItem5 = [GJRowItem new];
    subItem5.itemID = @2;
    subItem5.title = @"Class B";
    
    GJRowItem *subItem6 = [GJRowItem new];
    subItem6.itemID = @3;
    subItem6.title = @"Class C";
    
    NSMutableArray *subItems2 = [[NSMutableArray alloc] initWithObjects:subItem4, subItem5, subItem6, nil];
    
    GJSectionItem *item1 = [GJSectionItem new];
    item1.itemID = @1;
    item1.title = @"Course 1";
    item1.subItems = subItems;
    
    GJSectionItem *item2 = [GJSectionItem new];
    item2.itemID = @2;
    item2.title = @"Course 2";
    item2.subItems = subItems2;

    return @[item1, item2];
}
#pragma mark - GJExpandableTableViewDelegate
- (void)expandableTableView:(GJExpandableTableView *)tableView didSelectRowAtIndex:(NSIndexPath *)indexPath{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
