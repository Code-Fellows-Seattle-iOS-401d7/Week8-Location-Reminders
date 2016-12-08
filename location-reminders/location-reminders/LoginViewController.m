//
//  LoginViewController.m
//  location-reminders
//
//  Created by Corey Malek on 12/7/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<PFLogInViewControllerDelegate>

@property(readonly, strong, nonatomic, nullable) PFLogInView *logInView;
@property(assign, readwrite, nonatomic) PFLogInFields fields;
@property(readwrite, strong, nonatomic, nullable) UILabel *logo;

@end

@implementation LoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.logInView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
