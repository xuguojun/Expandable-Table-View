//
//  KTSwitchCourseTableRowCell.m
//  ExpandableTableViewDemo
//
//  Created by guojun on 6/4/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "GJExpandableTableCell.h"
#import "UIColor+GJColor.h"

@interface GJExpandableTableCell()

@property (nonatomic, strong) IBOutlet UILabel *classTextLabel;

@end

@implementation GJExpandableTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GJExpandableTableCell"
                                              owner:self
                                            options:nil] lastObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    self.classTextLabel.textColor = UIColorFromRGB(0x596880);
    self.classTextLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        
        self.classTextLabel.text = title;
    }
}

@end
