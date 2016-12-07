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



- (IBAction)saveReminderPressed:(UIButton *)sender {
    NSString *reminderTitle = @"Nre Reminder";
    NSNumber *radius = [NSNumber numberWithFloat:100.0];
    Reminder *newReminder = [Reminder object];
    newReminder.title = reminderTitle;
    newReminder.radius = radius;
    //TODO: change keyboard to numeric for radius input

    PFGeoPoint *reminderPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude
                                                       longitude:self.coordinate.longitude];

    newReminder.location = reminderPoint;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderCreated"
                                                        object:nil];

    if(self.completion) {
        MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:self.coordinate
                                                            radius:radius.floatValue];
        self.completion(newCircle);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


@end
