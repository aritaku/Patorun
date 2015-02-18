//
//  SearchListCell.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/12.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "SearchListCell.h"

@implementation SearchListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    if (selected)
    {
        if (self.selectionStyle != UITableViewCellSelectionStyleNone)
        {
            self.backgroundColor = [UIColor colorWithWhite:(float)220/255 alpha:1.0];
            //self.backgroundColor = [UIColor colorWithRed:(float)255/255 green:(float)140/255 blue:(float)0/255 alpha:0.20];
        }
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted)
    {
        if (self.selectionStyle != UITableViewCellSelectionStyleNone)
        {
            self.backgroundColor = [UIColor colorWithWhite:(float)220/255 alpha:1.0];
            //self.backgroundColor = [UIColor colorWithRed:(float)255/255 green:(float)140/255 blue:(float)0/255 alpha:0.20];
        }
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
