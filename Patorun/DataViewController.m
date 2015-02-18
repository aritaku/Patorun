//
//  DataViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/11.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "DataViewController.h"
#import "DataGraphCell.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad
{
    // set table UI
    self.table.tableFooterView = [[UIView alloc] init];
    
    // register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DataGraphCell" bundle:nil] forCellReuseIdentifier:@"DataGraphCell"];
}

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
            return 70.0f;
            break;
        case 1:
            return 131.0f;
            break;
    }
    
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const id identifiers[2] = { @"cell", @"DataGraphCell" };
    NSString *cell_identifier = identifiers[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (!cell) {
        switch ( indexPath.row ) {
            case 0:
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            case 1:
                cell = [[DataGraphCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
            default:
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
                break;
        }
    }
    
    switch ( indexPath.row ) {
        case 0:
        {
            cell.textLabel.text = @"not yet";
        }
            break;
        case 1:
        {
            DataGraphCell *custom_cell = (DataGraphCell *)cell;
            
            // set highlight
            custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            custom_cell.image.image = [UIImage imageNamed:@"graph-1.png"];
        }
            break;
        
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
