//
//  FindViewController.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/22.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()
{
    NSMutableArray* _image_views;
}

@end

@implementation FindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    static const id image_path[10] = { @"icon1.png", @"icon2.png", @"icon3.png", @"icon4.png", @"icon5.png", @"icon6.png", @"icon7.png", @"icon8.png", @"icon9.png", @"icon10.png" };
    static float intimacy[10] = { 300.0, 200.0, 73.0, 155.0, 98.0, 135.0, 400.0, 113.0, 115.0, 278.0};
    
    // my image back
    UIView* my_image_back = [[UIImageView alloc] initWithFrame:CGRectMake(253.0, 501.0, 60.0, 60.0)];
    my_image_back.backgroundColor = [UIColor orangeColor];
    my_image_back.layer.cornerRadius = my_image_back.bounds.size.width/2.0;
    my_image_back.layer.masksToBounds = YES;
    my_image_back.alpha = 0.35;
    [self.view addSubview:my_image_back];
    
    // my image
    UIImageView* my_image_view = [[UIImageView alloc] initWithFrame:CGRectMake(256.0, 504.0, 54.0, 54.0)];
    my_image_view.image = [UIImage imageNamed:@"icon0.png"];
    my_image_view.layer.cornerRadius = my_image_view.bounds.size.width/2.0;
    my_image_view.layer.masksToBounds = YES;
    [self.view addSubview:my_image_view];
    
    // start end my image back animation
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionRepeat
     |UIViewAnimationOptionCurveEaseOut
     |UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         my_image_back.transform = CGAffineTransformMakeScale(11.0/9.0, 11.0/9.0);
                         my_image_back.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:nil];
    
    self.icon1.layer.cornerRadius = 27.0;
    self.icon1.layer.masksToBounds = YES;
    self.icon2.layer.cornerRadius = 27.0;
    self.icon2.layer.masksToBounds = YES;
    self.icon3.layer.cornerRadius = 27.0;
    self.icon3.layer.masksToBounds = YES;
    self.icon4.layer.cornerRadius = 27.0;
    self.icon4.layer.masksToBounds = YES;
    self.icon5.layer.cornerRadius = 27.0;
    self.icon5.layer.masksToBounds = YES;
    self.icon6.layer.cornerRadius = 27.0;
    self.icon6.layer.masksToBounds = YES;
    self.icon7.layer.cornerRadius = 27.0;
    self.icon7.layer.masksToBounds = YES;
    self.icon8.layer.cornerRadius = 27.0;
    self.icon8.layer.masksToBounds = YES;
    self.icon9.layer.cornerRadius = 27.0;
    self.icon9.layer.masksToBounds = YES;
    self.icon10.layer.cornerRadius = 27.0;
    self.icon10.layer.masksToBounds = YES;
    self.icon11.layer.cornerRadius = 27.0;
    self.icon11.layer.masksToBounds = YES;
    self.icon12.layer.cornerRadius = 27.0;
    self.icon12.layer.masksToBounds = YES;
    
    [self.icon4 addTarget:self
                   action:@selector(pushedButton:event:)
         forControlEvents:UIControlEventTouchUpInside];
    
//    // other users' images
//    for (int i = 0; i < 10; i++) {
//        float rand_x;
//        if ( intimacy[i] < 280 ) rand_x =  (float)arc4random_uniform(intimacy[i]);
//        else rand_x = (float)arc4random_uniform(280);
//        float rand_y = sqrt( intimacy[i]*intimacy[i] - rand_x*rand_x );
//        
//        _image_views = [[NSMutableArray alloc]init];
//        UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake(256.0 - rand_x, 504.0 - rand_y, 54.0, 54.0)];
//        image_view.image = [UIImage imageNamed:image_path[i]];
//        image_view.layer.cornerRadius = image_view.bounds.size.width/2.0;
//        image_view.layer.masksToBounds = YES;
//        
//        [_image_views addObject:image_view];
//        [self.view addSubview:image_view];
//    }
}

- (void)pushedButton:(UIButton *)sender
               event:(UIEvent *)event
{
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.icon4.transform = CGAffineTransformMakeScale(9.0/6.0, 9.0/6.0);
                         self.icon4.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:^(BOOL finished){
                         UIAlertView *alert = [[UIAlertView alloc] init];
                         alert.delegate = self;
                         //alert.title = @"確認";
                         alert.message = @"Pingを送信しました";
                         [alert addButtonWithTitle:@"OK"];
                         [alert show];
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
