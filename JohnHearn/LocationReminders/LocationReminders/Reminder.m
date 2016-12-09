//
//  Reminder.m
//  LocationReminders
//
//  Created by John D Hearn on 12/7/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder
@dynamic title;
@dynamic radius;
@dynamic location;



+(NSString *)parseClassName{
    return @"Reminder";
}

+(void)load{
    [self registerSubclass];
}

@end
