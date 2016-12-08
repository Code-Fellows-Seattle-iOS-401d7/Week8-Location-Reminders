//
//  LoginViewController.m
//  location-reminders
//
//  Created by Erica Winberry on 12/7/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signUpController = [[SignupViewController alloc]init];
//    self.signUpController.emailAsUsername = NO;
    
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PLC_Mosaic_Stars"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImage.alpha = 0.8;
    
    [self.view insertSubview:backgroundImage atIndex:0];
    
    backgroundImage.clipsToBounds = YES;
    [backgroundImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundImage]|" options:0 metrics:nil views:@{@"backgroundImage": backgroundImage}];
    
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImage]|" options:0 metrics:nil views:@{@"backgroundImage": backgroundImage}];
    
    [NSLayoutConstraint activateConstraints:hConstraints];
    [NSLayoutConstraint activateConstraints:vConstraints];
    
    [self.view layoutIfNeeded];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = @"Location Reminders";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Futura" size:40.0];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.shadowColor = [UIColor darkGrayColor];

    self.logInView.logo = label;
    
}


@end
