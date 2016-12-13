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

@import UserNotifications;

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


- (IBAction)saveReminderPressed:(UIButton *)sender {
    
    NSString *reminderTitle = @"New Reminder";
    NSNumber *radius = [NSNumber numberWithFloat:100.0];
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.title = reminderTitle;
    newReminder.radius = radius;
    
    PFGeoPoint *reminderPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    
    newReminder.location = reminderPoint;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReminderCreated" object:nil];
    
    __weak typeof(self) bruce = self;
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        __strong typeof(bruce) hulk = bruce;

        
        if(error){
            NSLog(@"%@", error.localizedDescription);
            
        } else {
            NSLog(@"Save Reminder To Parse Success: %i", succeeded);
            
            
            if (hulk.completion) {
                
                if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:hulk.coordinate radius:radius.floatValue identifier: reminderTitle];
                    [[LocationController sharedController].manager startMonitoringForRegion:region];
                    
                    [hulk createNotificationForRegion:region withName:reminderTitle];
                    
                }
                
                MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:hulk.coordinate radius:radius.floatValue];
                hulk.completion(newCircle);
                
                [hulk.navigationController popViewControllerAnimated:YES];
                
            }

        }
        
    }];
    
    
    if (self.completion) {
        MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius.floatValue];
        self.completion(newCircle);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)createNotificationForRegion:(CLRegion *)region withName:(NSString *)reminderName{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Location Reminder";
    content.subtitle = @"subtitle text";
    content.body = reminderName;
    content.sound = [UNNotificationSound defaultSound];
    
//    UNNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:7.0 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:reminderName content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Error adding notification with Error:%@", error.localizedDescription);
        }
    }];
}




@end
















