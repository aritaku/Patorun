//
//  MySidePanelController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/11.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "MySidePanelController.h"

@interface MySidePanelController ()

@end

@implementation MySidePanelController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CenterNavigationController"]];
    
    // turn off the recognizer of swipe gesture
    self.recognizesPanGesture = NO;
}

@end
