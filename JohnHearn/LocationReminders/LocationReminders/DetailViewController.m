//
//  DetailViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/6/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"Annotation with Title: %@  -  Lat: %.5f, Long: %.5f",
          self.annotationTitle,
          self.coordinate.latitude,
          self.coordinate.longitude);
}



@end
