//
//  AppDelegate.m
//  location-reminders
//
//  Created by Corey Malek on 12/5/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "AppDelegate.h"
#import "ParseCredentials.h"

#import <Parse/Parse.h>
@import UserNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock: ^(id<ParseMutableClientConfiguration> _Nonnull configuration){
        
        configuration.applicationId = kApplicationID;
        configuration.clientKey = kClientKey;
        configuration.server= kServerURL;
    }]];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];

    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"%@", objects);
            }];
        }
    }];

    [self registerForNotifications];
    
    return YES;
}

-(void)registerForNotifications{
    UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(error){
            NSLog(@"User Notifications Error: %@", error.localizedDescription);
        }
        if(granted){
            NSLog(@"We Have Permissions For UserNotifications");
        }
    }];
}

@end














