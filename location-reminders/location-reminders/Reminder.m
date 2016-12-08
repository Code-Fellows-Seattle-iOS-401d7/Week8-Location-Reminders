//
//  Reminder.m
//  location-reminders
//
//  Created by Corey Malek on 12/7/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "Reminder.h"



@implementation Reminder

@dynamic title;
@dynamic radius;
@dynamic location;



+(NSString *)parseClassName{
    //whatever you return here will show up in Parse Dashboard.
    return @"Reminder";
}

+(void)load{
    [self registerSubclass];
}


@end
