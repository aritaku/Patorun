/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "MySidePanelController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"
#import "AppDefine.h"

#import <JASidePanelController.h>
#import <UIViewController+JASidePanel.h>

@interface LeftViewController ()

@end

@implementation LeftViewController

#pragma mark - Table view data source

- (void) viewDidLoad
{
    self.table.backgroundColor = [UIColor colorWithRed:(float)80/255 green:(float)80/255 blue:(float)80/255 alpha:1.0];
    self.table.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 28.0;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 28.0f)];
    view.backgroundColor = [UIColor colorWithRed:(float)80/255 green:(float)80/255 blue:(float)80/255 alpha:1.0];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(float)80/255 green:(float)80/255 blue:(float)80/255 alpha:1.0];
    
    cell.imageView.image = [UIImage imageNamed:[self __cellImgAtRow:indexPath.row]];
    cell.textLabel.textColor = [UIColor colorWithRed:(float)240/255 green:(float)240/255 blue:(float)240/255 alpha:1.0];
    cell.textLabel.text = [self __cellTitleAtRow:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// 通知を送信
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:kLeftViewDidSelectedCellNotification
					  object:self
					userInfo:@{kSelectCellRowTitleUserInfoKey : [self __cellTitleAtRow:indexPath.row]}];
	
	// ここでセンターを表示
	if ( indexPath.row == 0 ) [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CenterNavigationController"]];
    else if ( indexPath.row == 1 ) [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"DataNavigationController"]];
    else if ( indexPath.row == 2 ) [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FindNavigationController"]];
    else if ( indexPath.row == 3 ) [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MyPageNavigationController"]];
    else if ( indexPath.row == 4 ) [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"SettingNavigationController"]];
    //[self.sidePanelController showCenterPanelAnimated:YES];
}


#pragma mark -
#pragma mark ===== Privarte Methods =====
- (NSString*)__cellTitleAtRow:(NSInteger)row
{
    if (row == 0) return @"ホーム";
    else if (row == 1) return @"履歴";
    else if (row == 2) return @"探す";
    else if (row == 3) return @"マイページ";
    else return @"設定";

}

- (NSString*)__cellImgAtRow:(NSInteger)row
{
    if (row == 0) return @"home.png";
    else if (row == 1) return @"graph.png";
    else if (row == 2) return @"users.png";
    else if (row == 3) return @"mypage.png";
    else return @"setting.png";
}

@end
