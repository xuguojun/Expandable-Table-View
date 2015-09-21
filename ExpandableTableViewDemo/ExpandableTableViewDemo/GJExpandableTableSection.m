//
//  GJExpandableTableSection.m
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "GJExpandableTableSection.h"
#import "UIColor+GJColor.h"

@interface GJExpandableTableSection()

@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *accessoryImageView;
@property (nonatomic, strong) UITapGestureRecognizer *gesture;

@end

@implementation GJExpandableTableSection

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GJExpandableTableSection"
                                              owner:self
                                            options:nil] lastObject];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];    
    self.headerLabel.textColor = UIColorFromRGB(0x363f4d);
    self.headerLabel.font = [UIFont systemFontOfSize:14];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.gesture];
}

#pragma mark - Private Methods
- (void)headerViewDidTouch:(UITapGestureRecognizer *)sender{
    self.collapsed = !self.collapsed;
    if ([self.delegate respondsToSelector:@selector(expandableTableHeaderView:didCollapse:)]) {
        [self.delegate expandableTableHeaderView:self didCollapse:self.collapsed];
    }
}

#pragma mark - Getters & Setters
- (void)setSectionTitle:(NSString *)title{
    if (_sectionTitle != title) {
        _sectionTitle = title;
        self.headerLabel.text = title;
    }
}
- (void)setCollapsed:(BOOL)collapsed{
    if (_collapsed != collapsed) {
        _collapsed = collapsed;
        
        if (collapsed) {
            self.accessoryImageView.image = [UIImage imageNamed:@"down"];
        } else {
            self.accessoryImageView.image = [UIImage imageNamed:@"up"];

        }
        
        [self setNeedsLayout];
    }
}

- (UITapGestureRecognizer *)gesture{
    if (!_gesture) {
        _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewDidTouch:)];
    }
    
    return _gesture;
}

@end
