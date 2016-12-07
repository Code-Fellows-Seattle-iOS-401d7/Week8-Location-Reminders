//
//  DetailViewController.m
//  location-reminders
//
//  Created by Corey Malek on 12/6/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Annotation with Title: %@ - Lat:%.2f, Long: %.2f",
          self.annotationTitle,
          self.coordinate.latitude,
          self.coordinate.longitude);
}



@end
