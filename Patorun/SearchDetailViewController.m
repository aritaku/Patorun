//
//  SearchDetailViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/12.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchDetailCell.h"
#import "SearchMapCell.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController

#pragma mark - View Transition

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set close button
    UIBarButtonItem* rightItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                  target:self
                                                  action:@selector(pushedCloseButton:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.leftBarButtonItem.title = @"";
    
    // set table UI
    self.table.tableFooterView = [[UIView alloc] init];
    
    // set navigation title
    self.navigationItem.title = @"捜索情報詳細";
    
    // register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchDetailCell" bundle:nil] forCellReuseIdentifier:@"SearchDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchMapCell" bundle:nil] forCellReuseIdentifier:@"SearchMapCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return 420.0f;
            break;
        case 1:
            return 320.0f;
            break;
    }
    
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const id identifiers[2] = { @"SearchDetailCell", @"SearchMapCell" };
    NSString *cell_identifier = identifiers[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (!cell) {
        switch ( indexPath.row ) {
            case 0:
                cell = [[SearchDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            case 1:
                cell = [[SearchMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            default:
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
        }
    }
    
    switch ( indexPath.row ) {
        case 0:
        {
            SearchDetailCell *custom_cell = (SearchDetailCell *)cell;
            
            // set highlight
            custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // set pics
            custom_cell.image1.image = [UIImage imageNamed:@"image1.png"];
            custom_cell.image2.image = [UIImage imageNamed:@"image2.png"];
            
            custom_cell.image1.layer.cornerRadius = 7.0;
            custom_cell.image1.layer.masksToBounds = YES;
            custom_cell.image2.layer.cornerRadius = 7.0;
            custom_cell.image2.layer.masksToBounds = YES;
            
            // set find button
            custom_cell.find_button.layer.cornerRadius = 8.0;
            custom_cell.find_button.layer.masksToBounds = YES;
            [custom_cell.find_button addTarget:self
                                        action:@selector(pushedFindButton:event:)
                              forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 1:
        {
            SearchMapCell *custom_cell = (SearchMapCell *)cell;
            
            // set highlight
            custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // set map
            // set user location
            custom_cell.map.showsUserLocation = YES;
            
            // set target location
            CLLocationCoordinate2D target_location;
            target_location.latitude = 36.1109796;
            target_location.longitude = 140.1033913;
            
            // set pin of target location
            MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
            pin.title = @"筑波大学付近";
            pin.coordinate = target_location;
            [custom_cell.map addAnnotation:pin];
            
            // set map region
            MKCoordinateRegion map_region = custom_cell.map.region;
            map_region.center = target_location;
            map_region.span.latitudeDelta = 0.05;
            map_region.span.longitudeDelta = 0.05;
            [custom_cell.map setRegion:map_region animated:NO];
            //[custom_cell.map setCenterCoordinate:target_location animated:NO];
            
            
        }
            break;
    }
    
    return cell;
}

# pragma mark - Close Button

- (void)pushedCloseButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - Find Button

- (void)pushedFindButton:(UIButton *)sender
                   event:(UIEvent *)event
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"発見を依頼者に通知しますか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
}

@end
