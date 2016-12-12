//
//  DetailViewController.m
//  location-reminders
//
//  Created by Corey Malek on 12/6/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

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

//HOMEWORK: put two custom text fields inside this method.

- (IBAction)saveReminderPressed:(UIButton *)sender {
    
    NSString *reminderTitle = @"New Reminder";
    NSNumber *radius = [NSNumber numberWithFloat:100.0];
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.title = reminderTitle;
    newReminder.radius = radius;
    
    PFGeoPoint *reminderPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    
    newReminder.location = reminderPoint;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReminderCreated" object:nil];
    
    
    if (self.completion) {
        MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius.floatValue];
        self.completion(newCircle);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}










@end
















