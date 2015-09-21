//
//  GJExpandableTableView.m
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "GJExpandableTableView.h"
#import "GJExpandableTableSection.h"
#import "GJExpandableTableCell.h"
#import "GJSectionItem.h"
#import "GJRowItem.h"

#define KSection @"Section"
#define KTitle @"Title"
#define KSubitems @"Subitems"

@interface GJExpandableTableView()<UITableViewDataSource, UITableViewDelegate, GJExpandableTableSectionDelegate>{
    NSArray *headerViews;
}

@property (nonatomic, strong) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableDictionary *itemsDictionary;

@end

@implementation GJExpandableTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
    }
    
    return self;
}

- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"GJExpandableTableView"
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

#pragma mark - Private Methods
- (NSString *)keyForSection:(NSInteger)section{
    NSString *key = [NSString stringWithFormat:@"%@%ld", KSection, (long)section];
    
    return key;
}

- (NSArray *)subitemsForSection:(NSInteger)section{
    NSString *sectionKey = [self keyForSection:section];
    NSDictionary *dictionary = [self.itemsDictionary objectForKey:sectionKey];
    NSArray *subitems = [dictionary objectForKey:KSubitems];
    
    return subitems;
}

- (void)removeSubitemsForSection:(NSInteger)section{
    NSString *sectionKey = [self keyForSection:section];
    NSMutableDictionary *dictionary = [self.itemsDictionary objectForKey:sectionKey];
    [dictionary removeObjectForKey:KSubitems];
}

- (void)addSubitemsForSection:(NSInteger)section{
    NSString *sectionKey = [self keyForSection:section];
    NSMutableDictionary *dictionary = [self.itemsDictionary objectForKey:sectionKey];
    
    GJSectionItem *item = self.items[section];
    [dictionary setObject:item.subItems forKey:KSubitems];
}

- (void)fillData{
    if (self.itemsDictionary) {
        [self.itemsDictionary removeAllObjects];
    }
    
    for (int i = 0; i < self.items.count; i++) {
        GJSectionItem *item = self.items[i];
        
        NSMutableDictionary *itemDictionary = [[NSMutableDictionary alloc] init];
        [itemDictionary setObject:item.title forKey:KTitle];
        
        [self.itemsDictionary setObject:itemDictionary forKey:[self keyForSection:i]];
    }
}

- (NSArray *)rowsIndexPathForSection:(NSInteger)section{
    GJSectionItem *item = self.items[section];
    
    NSMutableArray *indexes = [NSMutableArray new];
    for (int i = 0; i < item.subItems.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
        [indexes addObject:index];
    }
    
    return indexes;
}

//- (int)getTargetSectionIndex {
//    // 1. search
//    int targetSection = 0;
//    
//    for (int i = 0; i < self.courses.count; i++) {
//        GJSectionItem *aClass = self.courses[i];
//        
//        for (GJRowItem *classItem in aClass.subItems) {
//            BOOL found = [classItem.classID isEqualToValue:self.currentClassID];
//            if (found) {
//                targetSection = i;
//                break;
//            }
//        }
//        
//        if (targetSection > 0) {
//            break;
//        }
//    }
//    
//    return targetSection;
//}

//- (void)scrollToCurrentClass{
//    if (self.currentClassID) {
//        
//        int targetSection = [self getTargetSectionIndex];
//            
//        // 2. scroll
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:targetSection];
//        [self.listTableView scrollToRowAtIndexPath:indexPath
//                                  atScrollPosition:(UITableViewScrollPositionTop)
//                                          animated:NO];
//    }
//}

//- (void)onlyOpenCurrentClass{
//    if (self.currentClassID) {
//        int targetSection = [self getTargetSectionIndex];
//        
//        GJExpandableTableHeaderView *headerView = headerViews[targetSection];
//        headerView.collapsed = NO;
//        [self addSubitemsForSection:targetSection];
//        [self.listTableView insertRowsAtIndexPaths:[self rowsIndexPathForSection:targetSection]
//                                  withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}

#pragma mark - KTSwitchCourseHeaderViewDelegate
- (void)expandableTableHeaderView:(GJExpandableTableSection *)section didCollapse:(BOOL)collapsed{
    
    if (collapsed) {
        [self removeSubitemsForSection:section.section];
        [self.listTableView deleteRowsAtIndexPaths:[self rowsIndexPathForSection:section.section]
                                  withRowAnimation:UITableViewRowAnimationMiddle];
    } else {
        [self addSubitemsForSection:section.section];
        [self.listTableView insertRowsAtIndexPaths:[self rowsIndexPathForSection:section.section]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *subitems = [self subitemsForSection:section];
    
    return subitems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifiler = @"cellIdentifiler";
    GJExpandableTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiler];
    if (!cell) {
        cell = [[GJExpandableTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellIdentifiler];
    }
    
    NSArray *subitems = [self subitemsForSection:indexPath.section];
    GJRowItem *subitem = [subitems objectAtIndex:indexPath.row];
    cell.title = subitem.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GJSectionItem *section = [self.items objectAtIndex:indexPath.section];
    GJRowItem *classItem = [section.subItems objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(expandableTableView:didSelectRowAtIndex:)]) {
        [self.delegate expandableTableView:self didSelectRowAtIndex:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return headerViews[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48.0f;
}

#pragma mark - Getters & Setters
- (GJExpandableTableSection *)headerView:(NSString *)title section:(NSInteger)section{
    GJExpandableTableSection *headerView = [[GJExpandableTableSection alloc] init];
    headerView.sectionTitle = title;
    headerView.section = section;
    headerView.collapsed = YES;
    headerView.delegate = self;
    return headerView;
}

- (void)setItems:(NSArray *)items{
    if (_items != items) {
        _items = items;
    
        [self initHeaderViews];
        [self fillData];
        [self.listTableView reloadData];

//        [self onlyOpenCurrentClass];
//        [self scrollToCurrentClass];
    }
}

- (void)initHeaderViews{
    
    if (headerViews) {
        headerViews = nil;
    }
    
    if (!headerViews) {
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.items.count];
        for (int i = 0; i < self.items.count; i++) {
            GJSectionItem *section = self.items[i];
            GJExpandableTableSection *headerView = [self headerView:section.title section:i];
            [array addObject:headerView];
        }
        
        headerViews = array;
    }
}

- (NSMutableDictionary *)itemsDictionary{
    if (!_itemsDictionary) {
        _itemsDictionary = [NSMutableDictionary new];
    }
    
    return _itemsDictionary;
}

@end
