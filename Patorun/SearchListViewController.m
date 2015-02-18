//
//  SearchListViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/11.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchDetailViewController.h"
#import "SearchListCell.h"

@interface SearchListViewController ()

@end

@implementation SearchListViewController

#pragma mark - View Transition

- (void)viewDidLoad
{
    // set close button
    UIBarButtonItem* rightItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                  target:self
                                                  action:@selector(pushedCloseButton:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // set table UI
    self.table.tableFooterView = [[UIView alloc] init];
    
    // register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchListCell" bundle:nil] forCellReuseIdentifier:@"SearchListCell"];
    
    // set next view's back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"戻る";
    self.navigationItem.backBarButtonItem = backButton;
}

#pragma mark - Table Setting

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchListCell"];
    if (!cell) cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchListCell"];
    
    SearchListCell *custom_cell = (SearchListCell *)cell;
    
    //custom_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // set search label
    if (indexPath.row == 0) custom_cell.search_label.text = @"捜索中";
    else custom_cell.search_label.text = @"発見済";
    
    if (indexPath.row == 0) custom_cell.search_label.backgroundColor = [UIColor redColor];
    else custom_cell.search_label.backgroundColor = [UIColor grayColor];
    
    custom_cell.search_label.layer.cornerRadius = 5;
    custom_cell.search_label.layer.masksToBounds = YES;
    
    // set detail label
    if (indexPath.row == 0) custom_cell.detail_label.text = @"つくば市 8月22日 18時30分";
    else if (indexPath.row == 1) custom_cell.detail_label.text = @"稲城市 7月5日 20時43分";
    else custom_cell.detail_label.text = @"守谷市 7月1日 7時43分";
        
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[tableView deselectRowAtIndexPath:indexPath animated:NO];

    SearchDetailViewController* next = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

# pragma mark - Close Button

- (void)pushedCloseButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
