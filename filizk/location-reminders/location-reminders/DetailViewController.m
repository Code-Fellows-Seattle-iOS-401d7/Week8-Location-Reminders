//
//  DetailViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/6/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"**Annotation With Title:%@ - Lat:%.2f, Long:%.2f",
          self.annotationTitle,
          self.coordinate.latitude,
          self.coordinate.longitude);
    //initWithLatitude:longitude:
}

- (IBAction)saveReminder:(id)sender {
    NSString *reminderTitle = @"New Reminder";
    NSNumber *radius = [NSNumber numberWithFloat:100.0];

    Reminder *newReminder = [Reminder object];
    newReminder.title = reminderTitle;
    newReminder.radius = radius;

    PFGeoPoint *reminderPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];

    newReminder.location = reminderPoint;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderCreated" object:nil];

    if (self.completion) {
        MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius.floatValue];
        self.completion(newCircle);

        [self.navigationController popViewControllerAnimated:YES];
    }



}



@end
