//
//  GJSectionItem.h
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJSectionItem : NSObject

@property (nonatomic, strong) NSNumber *itemID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *subItems;// contains [GJRowItem]

@end
