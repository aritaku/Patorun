//
//  ResultViewController.h
//  Patorun
//
//  Created by yoshitooooom on 2014/08/12.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ResultViewController : UITableViewController <MKMapViewDelegate>
{
    NSMutableArray *_geo_data;
    NSString *_distance;
    NSString *_time;
    NSString *_mean_speed;
}

@property (nonatomic) NSString *distance;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *mean_speed;
@property (nonatomic) NSMutableArray *geo_data;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end
