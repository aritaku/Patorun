//
//  ResultMapCell.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/12.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "ResultMapCell.h"

@implementation ResultMapCell

- (void)awakeFromNib
{
    // Initialization code
    
//    NSLog(@"aa");
//    
//    CLLocationCoordinate2D coors[2];
//    coors[0] = CLLocationCoordinate2DMake(36.1109796, 140.1033913);
//    coors[1] = CLLocationCoordinate2DMake(37.7109796, 140.9033913);
//    MKPolyline *line = [MKPolyline polylineWithCoordinates:coors
//                                                     count:2];
//    [self.map addOverlay:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - MKMapViewDelegate

//// 地図上に描画するルートの色などを指定（これを実装しないと何も表示されない）
//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
//            rendererForOverlay:(id<MKOverlay>)overlay
//{
//    
//    NSLog(@"bb");
//    if ([overlay isKindOfClass:[MKPolyline class]])
//    {
//        MKPolyline *route = overlay;
//        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
//        routeRenderer.lineWidth = 5.0;
//        routeRenderer.strokeColor = [UIColor redColor];
//        return routeRenderer;
//    }
//    else {
//        return nil;
//    }
//}

@end
