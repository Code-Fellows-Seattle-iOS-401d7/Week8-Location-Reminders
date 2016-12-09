//
//  DetailViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/6/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "DetailViewController.h"
#import "LocationController.h"
@import UserNotifications;

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

    __weak typeof(self) bruceBanner = self;

    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        __strong typeof(bruceBanner) hulk = bruceBanner;

        if(error) {
            NSLog(@"%@",error.localizedDescription);
        }
        else {
            NSLog(@"Save New Reminder to Parse Success: %i", succeeded);


            if(self.completion){


                if([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                    CLCircularRegion *region =
                            [[CLCircularRegion alloc] initWithCenter:hulk.coordinate
                                                             radius:newReminder.radius.floatValue
                                                         identifier:newReminder.title];          //TODO: Find a better identifier

                    [[LocationController sharedController].manager startMonitoringForRegion:region];

                    [hulk createNotificationForRegion:region withName:newReminder.title];
                }

                MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:hulk.coordinate
                                                                    radius:radius.floatValue];
                hulk.completion(newCircle);
                [hulk.navigationController popViewControllerAnimated:YES];
            }

        }
    }];


//    newReminder.location = reminderPoint;
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderCreated"
//                                                        object:nil];
//
//    if(self.completion) {
//        MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:self.coordinate
//                                                            radius:radius.floatValue];
//        self.completion(newCircle);
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
}


-(void)createNotificationForRegion:(CLRegion *)region withName:(NSString *)reminderName{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Location Reminder";
    content.body = [NSString stringWithFormat:@"You're close to %@", reminderName];
    content.sound = [UNNotificationSound defaultSound];

    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region
                                                                                      repeats:YES];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:reminderName  //TODO: bad identifier
                                                                          content:content
                                                                          trigger:trigger];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Eror adding notification:", error);
        }
    }];
}

@end
