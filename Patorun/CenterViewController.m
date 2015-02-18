//
//  ViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/10.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "CenterViewController.h"
#import "AppDefine.h"
#import "SearchListViewController.h"
#import "ResultViewController.h"
#import <QuartzCore/QuartzCore.h>

#define TH_SWIPE 150

@interface CenterViewController ()
{
    int _state;
    
    // timer
    NSTimer* _timer;
    NSDate* _timeStd;
    float _time;
    float _time_amount;
    
    // distance
    float _distance_amount;
    
    // images
    UIImage *_start_image;
    UIImage *_stop_image;
    
    // lacation manager
    CLLocationManager *_locationManager;
    
    NSMutableArray* _geo_data;
    
    // touch
    float p1x, p1y, p2x, p2y, distance;
}
@end

enum STATE{
    STATE_BEFORE_START = 0,
    STATE_RUN,
    STATE_STOP
};

@implementation CenterViewController

- (void)initValuables
{
    _state = STATE_BEFORE_START;
    _geo_data = [[NSMutableArray alloc] init];
    self.distance_label.text = @"0.00 km";
    self.mean_speed_label.text = @"0'00'' /km";
    self.time_label.text = @"00:00";
    _distance_amount = 0.0;
    
    [self.button setBackgroundImage:_start_image forState:UIControlStateNormal];
    self.slide.alpha = 0.0;
    
    // init timer
    _time_amount = 0.0f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:(0.001)
                                              target:self selector:@selector(onTimer:)
                                            userInfo:nil repeats:YES];
}

# pragma mark - View Transition

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set image
    _start_image = [UIImage imageNamed:@"start.png"];
    _stop_image = [UIImage imageNamed:@"stop.png"];
    
    // init
    [self initValuables];
   
    // set navigation title
    UIImageView *logo_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 204.0, 44.0)];
    logo_view.image = [UIImage imageNamed:@"logo.png"];
    [self.navigationItem.titleView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = logo_view;
    
    NSLog(@"%f", self.navigationItem.titleView.bounds.size.width);
    
    // set location manager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // set right button on navigation bar
    UIBarButtonItem* rightItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bell.png"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(pushedRightButton:event:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // set UI
    // set start button image
    [self.button setBackgroundImage:_start_image forState:UIControlStateNormal];
    
    // set labels
    self.distance_label.layer.cornerRadius = 65.0;
    self.distance_label.layer.masksToBounds = YES;
    
    self.mean_speed_label.layer.cornerRadius = 50.0;
    self.mean_speed_label.layer.masksToBounds = YES;
    
    self.time_label.layer.cornerRadius = 50.0;
    self.time_label.layer.masksToBounds = YES;
    
    // set run button
    self.button.layer.cornerRadius = 43.0;
    self.button.layer.masksToBounds = YES;
    [self.button addTarget:self
                action:@selector(pushedRunButton:event:)
      forControlEvents:UIControlEventTouchUpInside];
    
    // set next view's back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    
	// set notification from left panel
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(__leftSelectCellRowNotification:) name:kLeftViewDidSelectedCellNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initValuables];
}

- (void)dealloc
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self name:kLeftViewDidSelectedCellNotification object:nil];
}

- (void)__leftSelectCellRowNotification:(NSNotification *)notification
{
	NSDictionary *dict = [notification userInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Button Pushed

- (void)pushedRightButton:(UIButton *)sender
                    event:(UIEvent *)event
{
    UINavigationController* next = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchListNavigationController"];
    next.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:next animated:YES completion:nil];
}

- (void)pushedRunButton:(UIButton *)sender
                  event:(UIEvent *)event
{
    // animation
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.button.transform = CGAffineTransformMakeScale(5.0/3.0, 5.0/3.0);
                         self.button.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     } completion:^(BOOL finished) {
                         if ( _state == STATE_BEFORE_START ) { // BEFORE_START -> RUN
                             // time
                             _timeStd = [NSDate date];
                             
                             // change state
                             _state = STATE_RUN;
                             
                             // change button UI
                             //[self.button setTitle:@"一時停止" forState:UIControlStateNormal];
                             [self.button setBackgroundImage:_stop_image forState:UIControlStateNormal];
                             
                             // start location manager
                             [_locationManager startUpdatingLocation];
                             
                             // start animation
                             [UIView animateWithDuration:1.0f
                                                   delay:0.0f
                                                 options:UIViewAnimationOptionRepeat
                                                        |UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  //self.alpha = 0.0; // alphaを0にする
                                                  //self.bounds = CGRectMake(0, 0, 192, 192);
                                                  self.time_label.transform = CGAffineTransformMakeScale(9.0/7.0, 9.0/7.0);
                                                  self.time_label.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                              }
                                              completion:nil];
                         } else if ( _state == STATE_RUN ) { // RUN -> STOP
                             // time
                             NSDate *now = [NSDate date];
                             _time_amount += [now timeIntervalSinceDate:_timeStd];
                             
                             // change state
                             _state = STATE_STOP;
                             
                             // change button UI
                             //[self.button setTitle:@"再開" forState:UIControlStateNormal];
                             [self.button setBackgroundImage:_start_image forState:UIControlStateNormal];
                             
                             // stop geo location
                             [_locationManager stopUpdatingLocation];
                             
                             // stop time label animation
                             [self.time_label.layer removeAllAnimations];
                             
                             // start end animation
                             [UIView animateWithDuration:1.2f
                                                   delay:0.0f
                                                 options:UIViewAnimationOptionRepeat
                              |UIViewAnimationOptionCurveEaseOut
                              |UIViewAnimationOptionAllowUserInteraction
                                              animations:^(void){
                                                  self.slide.alpha = 1.0;
                                                  self.slide.alpha = 0.2;
                                              }
                                              completion:nil];
                         } else if ( _state == STATE_STOP ) { // STOP -> RUN
                             // time
                             _timeStd = [NSDate date];
                             
                             // change state
                             _state = STATE_RUN;
                             
                             // change button UI
                             //[self.button setTitle:@"一時停止" forState:UIControlStateNormal];
                             [self.button setBackgroundImage:_stop_image forState:UIControlStateNormal];
                             
                             // start geo location
                             [_locationManager startUpdatingLocation];
                             
                             // stop end animation
                             self.slide.alpha = 0.0;
                             [self.slide.layer removeAllAnimations];
                             
                             // start time label animation
                             [UIView animateWithDuration:1.0f
                                                   delay:0.0f
                                                 options:UIViewAnimationOptionRepeat
                              |UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  //self.alpha = 0.0; // alphaを0にする
                                                  //self.bounds = CGRectMake(0, 0, 192, 192);
                                                  self.time_label.transform = CGAffineTransformMakeScale(9.0/7.0, 9.0/7.0);
                                                  self.time_label.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                              }
                                              completion:nil];
                         }
                     }];
}

# pragma mark - Timer

- (void)onTimer:(NSTimer*)timer
{
    if ( _state == STATE_RUN ) {
        NSDate *now = [NSDate date];
        _time = [now timeIntervalSinceDate:_timeStd] + _time_amount;
        self.time_label.text = [NSString stringWithFormat:@"%02d:%02d", (int)_time/60, (int)_time%60];
    }
}

# pragma mark - GPS

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // set geo data
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude] forKey:@"latitude"];
    [dic setObject:[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude] forKey:@"longitude"];
    [_geo_data addObject:dic];
    
    // calc distance
    _distance_amount += (float)[newLocation getDistanceFrom:oldLocation];
    self.distance_label.text = [NSString stringWithFormat:@"%1.2f km", _distance_amount/1000.0];
    NSLog(@"移動：%f m", (float)[newLocation getDistanceFrom:oldLocation]);
    
    // calc mean speed
    float t = _time/_distance_amount*1000.0;
    NSLog(@"移動変位：%f m", _distance_amount);
    NSLog(@"時間変位：%f sec", _time_amount);
    NSLog(@"速度：%f sec/km", t);
    self.mean_speed_label.text = [NSString stringWithFormat:@"%01d'%02d'' /km", (int)t/60, (int)t%60];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}

# pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Touch point
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
    p1x = location.x;
    p1y = location.y;
    
    NSLog(@"touch start at %f %f", p1x, p1y);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Touch point
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
    p2x = location.x;
    p2y = location.y;
    
    NSLog(@"touch end at %f %f", p2x, p2y);
    
    // Displacement
    float dx = p2x - p1x;
    float dy = p2y - p1y;
    distance = sqrtf( dx*dx + dy*dy );
    
    // Judge kind of input
    if( distance > TH_SWIPE && p1y > self.view.bounds.size.height/2.0 && p2y > self.view.bounds.size.height/2.0 && _state == STATE_STOP ){
        // stop end animation
        self.slide.alpha = 0.0;
        [self.slide.layer removeAllAnimations];
        
        // stop location manager
        [_locationManager stopUpdatingLocation];
        
        NSLog(@"num data : %d\n", (int)_geo_data.count);
        NSLog(@"%@", _geo_data);
        
        // start animation
        [UIView animateWithDuration:1.0f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.mean_speed_label.transform = CGAffineTransformMakeScale(2.0, 2.0);
                             self.mean_speed_label.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             
                             self.time_label.transform = CGAffineTransformMakeScale(2.0, 2.0);
                             self.time_label.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             
                             self.distance_label.transform = CGAffineTransformMakeScale(2.0, 2.0);
                             self.distance_label.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             
                             self.button.transform = CGAffineTransformMakeScale(2.0, 2.0);
                             self.button.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
                         completion:^(BOOL finished){
                             // segue to next view
                             ResultViewController* next = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
                             next.geo_data = _geo_data;
                             next.distance = self.distance_label.text;
                             next.time = self.time_label.text;
                             next.mean_speed = self.mean_speed_label.text;
                             [self.navigationController pushViewController:next animated:YES];
                         }];
    }
    
}

@end
