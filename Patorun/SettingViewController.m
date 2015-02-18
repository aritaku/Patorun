//
//  SettingViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/11.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    self.table.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor colorWithRed:(float)85/255 green:(float)85/255 blue:(float)85/255 alpha:1.0];
    
//	UIImageView *back_image = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 28.0f)];
//    back_image.image = [UIImage imageNamed:@"bar_cream_32.png"];
 	
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 28.0f)];
    [label setTextColor:[UIColor colorWithRed:(float)255/255 green:(float)255/255 blue:(float)255/255 alpha:1.0]];
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    
    switch (section) {
        case 0:
            label.text = @"　アカウント設定";
            break;
        case 1:
            label.text = @"　ランニング設定";
            break;
        case 2:
            label.text = @"　アプリ情報";
            break;
    }
    
    //[view addSubview:back_image];
    [view addSubview:label];
    
    return view;
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.imageView.image = [UIImage imageNamed:@"setting.png"];
    //cell.textLabel.textColor = [UIColor colorWithRed:(float)240/255 green:(float)240/255 blue:(float)240/255 alpha:1.0];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) cell.textLabel.text = @"プロフィール設定";
            else if (indexPath.row == 1) cell.textLabel.text = @"シェア機能の設定";
            break;
        case 1:
            if (indexPath.row == 0) cell.textLabel.text = @"音声フィードバックの設定";
            else if (indexPath.row == 1) cell.textLabel.text = @"GPS機能の設定";
            else if (indexPath.row == 2) cell.textLabel.text = @"プッシュ通知の設定";
            break;
        case 2:
            if (indexPath.row == 0) cell.textLabel.text = @"パトランについて";
            else if (indexPath.row == 1) cell.textLabel.text = @"プライバシーポリシー";
            else if (indexPath.row == 2) cell.textLabel.text = @"利用規約";
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
