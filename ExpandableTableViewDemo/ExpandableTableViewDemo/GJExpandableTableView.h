//
//  GJExpandableTableView.h
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJExpandableTableView;
@protocol GJExpandableTableViewDelegate <NSObject>

- (void)expandableTableView:(GJExpandableTableView *)tableView didSelectRowAtIndex:(NSIndexPath *)indexPath;

@end

IB_DESIGNABLE
@interface GJExpandableTableView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSNumber *currentSubitemID;

@property (nonatomic, assign) IBOutlet id <GJExpandableTableViewDelegate> delegate;

@end
