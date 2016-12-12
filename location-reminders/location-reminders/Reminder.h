//
//  Reminder.h
//  location-reminders
//
//  Created by Corey Malek on 12/7/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSNumber *radius;
@property(strong, nonatomic) PFGeoPoint *location;

@end
