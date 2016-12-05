//
//  ViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/5/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "ViewController.h"
@import Parse;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    PFObject * testObject = [PFObject objectWithClassName:@"TestObject"];

    testObject[@"foo"] = @"bar";

    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }

        if(succeeded) {
            NSLog(@"Successfully saved testObject");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
