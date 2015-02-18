//
//  ResultDataCell.h
//  Patorun
//
//  Created by yoshitooooom on 2014/08/22.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *distance_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *mean_speed_label;
@property (weak, nonatomic) IBOutlet UIButton *facebook_button;
@property (weak, nonatomic) IBOutlet UIButton *tweet_button;


@end
