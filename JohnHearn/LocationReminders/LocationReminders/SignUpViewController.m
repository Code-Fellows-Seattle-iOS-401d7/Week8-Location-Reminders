//
//  SignUpViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/7/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageNamed:@"portal_logo"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    self.signUpView.logo = imageView;
    [self.view addSubview:imageView];

    UIColor *portalBlue = [UIColor colorWithRed:0.22
                                          green:0.76
                                           blue:0.99
                                          alpha:1.0];

    UIColor *portalOrange = [UIColor colorWithRed:0.95
                                            green:0.33
                                             blue:0.04
                                            alpha:1.0];



    /* ATTN: All the commmented code causes (identical) runtime crashes */


    //self.signUpView.backgroundColor = [UIColor blackColor];
    //self.view.backgroundColor = [UIColor blackColor];


    self.signUpView.usernameField.backgroundColor = portalBlue;
//    self.signUpView.usernameField.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:@"Email"
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkTextColor]}];
    self.signUpView.usernameField.textColor = [UIColor blackColor];
    self.signUpView.usernameField.separatorColor = [UIColor blackColor];
    self.signUpView.passwordField.backgroundColor = portalBlue;
//    self.signUpView.passwordField.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:@"Password"
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkTextColor]}];
    self.signUpView.passwordField.textColor = [UIColor blackColor];
    self.signUpView.passwordField.separatorColor = [UIColor blackColor];

    self.signUpView.emailField.backgroundColor = portalBlue;
//    self.signUpView.emailField.textColor = [UIColor blackColor];
//    self.signUpView.emailField.separatorColor = [UIColor blackColor];

//    [self.signUpView.signUpButton setBackgroundImage:nil
//                                          forState:UIControlStateNormal];
//    self.signUpView.signUpButton.backgroundColor = portalOrange;
//    self.signUpView.signUpButton.tintColor = portalOrange;


}


@end
