//
//  ResultViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/12.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultMapCell.h"
#import "ResultDataCell.h"
#import <Social/Social.h>

@interface ResultViewController ()
{
    NSTimer* _timer;
    NSDate* _timeStd;
    float _pre_time;
    float _cur_time;
    UIImage* _share_image;
}
@end

@implementation ResultViewController

@synthesize distance = _distance;
@synthesize time = _time;
@synthesize mean_speed = _mean_speed;
@synthesize geo_data = _geo_data;

#pragma mark - View Transition

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set navigation title
    self.navigationItem.title = @"ランニング結果";
    
    // set table UI
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableFooterView = [[UIView alloc] init];
    
    // register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultMapCell" bundle:nil] forCellReuseIdentifier:@"ResultMapCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultDataCell" bundle:nil] forCellReuseIdentifier:@"ResultDataCell"];
    
    // init timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:(0.001)
                                              target:self selector:@selector(onTimer:)
                                            userInfo:nil repeats:YES];
    _timeStd = [NSDate date];
    _pre_time = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Timer

- (void)onTimer:(NSTimer*)timer
{
    NSDate *now = [NSDate date];
    float _cur_time = [now timeIntervalSinceDate:_timeStd];
    
    if ( (int)_cur_time > (int)_pre_time ) {
        if ((int)(_cur_time)%6 == 1) {
        } else if ((int)(_cur_time)%6 == 2) {
            
        } else if ((int)(_cur_time)%6 == 3) {
        }
    }
    _pre_time = _cur_time;
}

#pragma mark - Table Setting

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 320.0f;
            break;
        case 1:
            return 260.0f;
            break;
    }
    
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const id identifiers[2] = { @"ResultMapCell", @"ResultDataCell" };
    NSString *cell_identifier = identifiers[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (!cell) {
        switch ( indexPath.row ) {
            case 0:
                cell = [[ResultMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            case 1:
                cell = [[ResultDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            default:
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
        }
    }
    
    switch ( indexPath.row ) {
        case 0:
        {
            ResultMapCell *custom_cell = (ResultMapCell *)cell;
            
            // set highlight
            custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // set map
            // set delegate
            [custom_cell.map setDelegate:self];
            
//            // set target location
//            CLLocationCoordinate2D target_location;
//            target_location.latitude = 36.1109796;
//            target_location.longitude = 140.1033913;
//            
//            // set map region
//            MKCoordinateRegion map_region = custom_cell.map.region;
//            map_region.center = target_location;
//            map_region.span.latitudeDelta = 0.03;
//            map_region.span.longitudeDelta = 0.03;
//            [custom_cell.map setRegion:map_region animated:NO];
//            //[custom_cell.map setCenterCoordinate:target_location animated:NO];
            
            // draw running track
            CLLocationCoordinate2D tracks[_geo_data.count];
            for (int i = 0; i < _geo_data.count; i++) {
                tracks[i] = CLLocationCoordinate2DMake([_geo_data[i][@"latitude"] floatValue], [_geo_data[i][@"longitude"] floatValue]);
            }
            
            MKPolyline *line = [MKPolyline polylineWithCoordinates:tracks
                                                             count:_geo_data.count];
            [custom_cell.map addOverlay:line];
            
            // set map center & region
            double minLat = 9999.0;
            double minLng = 9999.0;
            double maxLat = -9999.0;
            double maxLng = -9999.0;
            double lat, lng;
            
            for (int i = 0; i < _geo_data.count; i++) {
                lat = [_geo_data[i][@"latitude"] floatValue];
                lng = [_geo_data[i][@"longitude"] floatValue];
                
                if (minLat > lat) minLat = lat;
                if (lat > maxLat) maxLat = lat;
                
                if (minLng > lng) minLng = lng;
                if (lng > maxLng) maxLng = lng;
            }
            
            CLLocationCoordinate2D center = CLLocationCoordinate2DMake((maxLat + minLat) / 2.0, (maxLng + minLng) / 2.0);
            MKCoordinateSpan span = MKCoordinateSpanMake(maxLat - minLat, maxLng - minLng);
            MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
            
            [custom_cell.map setRegion:[custom_cell.map regionThatFits:region] animated:YES];
            
            // get snap shot of map
            MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
            options.region = custom_cell.map.region;
            options.scale = [UIScreen mainScreen].scale;
            options.size = custom_cell.map.frame.size;
            
            MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
            [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
                //_share_image = snapshot.image;
                _share_image = [self drawRoute:line onSnapshot:snapshot withColor:[UIColor orangeColor]];
                
                //NSData *data = UIImagePNGRepresentation(image);
                //[data writeToFile:[self snapshotFilename] atomically:YES];
            }];
        }
            break;
        case 1:
        {
            ResultDataCell *custom_cell = (ResultDataCell *)cell;
            
            // set highlight
            custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // set labels
            custom_cell.distance_label.layer.cornerRadius = 50.0;
            custom_cell.distance_label.layer.masksToBounds = YES;
            custom_cell.distance_label.text = _distance;
            
            custom_cell.mean_speed_label.layer.cornerRadius = 50.0;
            custom_cell.mean_speed_label.layer.masksToBounds = YES;
            custom_cell.mean_speed_label.text = _mean_speed;
            
            custom_cell.time_label.layer.cornerRadius = 50.0;
            custom_cell.time_label.layer.masksToBounds = YES;
            custom_cell.time_label.text = _time;
            
            // set buttons
            custom_cell.facebook_button.layer.cornerRadius = 3.0f;
            custom_cell.facebook_button.clipsToBounds = YES;
            custom_cell.tweet_button.layer.cornerRadius = 3.0f;
            custom_cell.tweet_button.clipsToBounds = YES;
            
            [custom_cell.facebook_button addTarget:self
                                            action:@selector(pushedFacebook:event:)
                                  forControlEvents:UIControlEventTouchUpInside];
            [custom_cell.tweet_button addTarget:self
                                         action:@selector(pushedTwitter:event:)
                               forControlEvents:UIControlEventTouchUpInside];
            
            // start animation
            [UIView animateWithDuration:1.0f
                                  delay:0.0f
                                options:UIViewAnimationOptionRepeat
                                        |UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 custom_cell.mean_speed_label.transform = CGAffineTransformMakeTranslation(0.0, -4.0);
                                 custom_cell.mean_speed_label.transform = CGAffineTransformMakeTranslation(0.0, 4.0);
                                 
                                 custom_cell.time_label.transform = CGAffineTransformMakeTranslation(0.0, -4.0);
                                 custom_cell.time_label.transform = CGAffineTransformMakeTranslation(0.0, 4.0);
                                 
                                 custom_cell.distance_label.transform = CGAffineTransformMakeTranslation(0.0, -4.0);
                                 custom_cell.distance_label.transform = CGAffineTransformMakeTranslation(0.0, 4.0);
                                 
                             }
                             completion:^(BOOL finished){
                                
                             }];
        }
            break;
    }
    
    return cell;
}

#pragma mark - Button Push

- (void)pushedFacebook:(UIButton *)sender
                 event:(UIEvent *)event
{
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:[NSString stringWithFormat:@"パトランしました！ #PatoRun"]];
    [vc addImage:_share_image];
//    NSString *str = [NSString stringWithFormat:@"http://makey.asia/make.php?id=%@", _recipe_id];
//    [vc addURL:[NSURL URLWithString:str]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)pushedTwitter:(UIButton *)sender
                event:(UIEvent *)event
{
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:[NSString stringWithFormat:@"パトランしました！ #PatoRun"]];
    [vc addImage:_share_image];
//    NSString *str = [NSString stringWithFormat:@"http://makey.asia/make.php?id=%@", _recipe_id];
//    [vc addURL:[NSURL URLWithString:str]];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.lineWidth = 5.0;
        routeRenderer.strokeColor = [UIColor orangeColor];
        return routeRenderer;
    }
    else {
        return nil;
    }
}

#pragma mark - MKMap Library

- (UIImage *)drawRoute:(MKPolyline *)polyline onSnapshot:(MKMapSnapshot *)snapShot withColor:(UIColor *)lineColor {
    
    UIGraphicsBeginImageContext(snapShot.image.size);
    CGRect rectForImage = CGRectMake(0, 0, snapShot.image.size.width, snapShot.image.size.height);
    
    // Draw map
    [snapShot.image drawInRect:rectForImage];
    
    // Get points in the snapshot from the snapshot
    int lastPointIndex;
    int firstPointIndex = 0;
    BOOL isfirstPoint = NO;
    NSMutableArray *pointsToDraw = [NSMutableArray array];
    for (int i = 0; i < polyline.pointCount; i++){
        MKMapPoint point = polyline.points[i];
        CLLocationCoordinate2D pointCoord = MKCoordinateForMapPoint(point);
        CGPoint pointInSnapshot = [snapShot pointForCoordinate:pointCoord];
        if (CGRectContainsPoint(rectForImage, pointInSnapshot)) {
            [pointsToDraw addObject:[NSValue valueWithCGPoint:pointInSnapshot]];
            lastPointIndex = i;
            if (i == 0)
                firstPointIndex = YES;
            if (!isfirstPoint) {
                isfirstPoint = YES;
                firstPointIndex = i;
            }
        }
    }
    
    // Adding the first point on the outside too so we have a nice path
    if (lastPointIndex+1 <= polyline.pointCount) {
        MKMapPoint point = polyline.points[lastPointIndex+1];
        CLLocationCoordinate2D pointCoord = MKCoordinateForMapPoint(point);
        CGPoint pointInSnapshot = [snapShot pointForCoordinate:pointCoord];
        [pointsToDraw addObject:[NSValue valueWithCGPoint:pointInSnapshot]];
    }
    // Adding the point before the first point in the map as well (if needed) to have nice path
    
    if (firstPointIndex != 0) {
        MKMapPoint point = polyline.points[firstPointIndex-1];
        CLLocationCoordinate2D pointCoord = MKCoordinateForMapPoint(point);
        CGPoint pointInSnapshot = [snapShot pointForCoordinate:pointCoord];
        [pointsToDraw insertObject:[NSValue valueWithCGPoint:pointInSnapshot] atIndex:0];
    }
        
    // Draw that points
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    
    for (NSValue *point in pointsToDraw){
        CGPoint pointToDraw = [point CGPointValue];
        if ([pointsToDraw indexOfObject:point] == 0){
            CGContextMoveToPoint(context, pointToDraw.x, pointToDraw.y);
        } else {
            CGContextAddLineToPoint(context, pointToDraw.x, pointToDraw.y);
        }
    }
    
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextStrokePath(context);
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
