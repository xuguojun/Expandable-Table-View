//
//  GJExpandableTableSection.h
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//


#import <UIKit/UIKit.h>

@class GJExpandableTableSection;
@protocol GJExpandableTableSectionDelegate <NSObject>

@required
- (void)expandableTableHeaderView:(GJExpandableTableSection *)section didCollapse:(BOOL)collapsed;

@end

@interface GJExpandableTableSection : UIView

@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL collapsed;
@property (nonatomic, weak) id<GJExpandableTableSectionDelegate> delegate;

@end
