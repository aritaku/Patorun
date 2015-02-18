//
//  ViewController.h
//  Patorun
//
//  Created by yoshitooooom on 2014/08/10.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface CenterViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *distance_label;
@property (weak, nonatomic) IBOutlet UILabel *mean_speed_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *slide;

@end
